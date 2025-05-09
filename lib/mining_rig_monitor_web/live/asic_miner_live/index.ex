defmodule MiningRigMonitorWeb.AsicMinerLive.Index do
  use MiningRigMonitorWeb, :live_view_container_grow

  alias MiningRigMonitor.AsicMiners
  alias MiningRigMonitor.AsicMiners.AsicMiner
  alias MiningRigMonitor.Utility

  require Logger

  embed_templates "index_html/*"
  on_mount MiningRigMonitorWeb.UserAuthLive

  @impl true
  def mount(_params, _session, socket) do
    asic_miner_not_activated_list = AsicMiners.list_asic_miners_by_activated_state(false)
    asic_miner_activated_list = AsicMiners.list_asic_miners_by_activated_state(true)
    |> Enum.map(fn(e) ->
      %{
        id: e.id,
        name: e.name,
        model: e.model,
        model_variant: e.model_variant,
        asic_expected_status: e.asic_expected_status,
        light_expected_status: e.light_expected_status,
        hashrate_5_min: "Sync...",
        hashrate_30_min: "Sync...",
        coin: "Sync...",
        power: "Sync...",
        max_hashboard_temp: "Sync...",
        max_fan: "Sync...",
        uptime: "Sync...",
        uptime_class: "badge badge-info"
  }
    end)
    aggregated_coin_hashrate_map = %{"Crypto" => {"Hashrate Sync...", nil} }
    aggregated_total_power = "Sync..."
    aggregated_asic_miner_alive = "Sync..."

    if connected?(socket) do
      Phoenix.PubSub.subscribe(MiningRigMonitor.PubSub, "asic_miner_index_channel")
      Phoenix.PubSub.subscribe(MiningRigMonitor.PubSub, "flash_index")
      Phoenix.PubSub.subscribe(MiningRigMonitor.PubSub, "asic_miner_index_operational_channel")
    end

    new_socket = socket
    |> assign(:page_title, "ASIC Miner Index")
    |> stream(:asic_miner_activated_list, asic_miner_activated_list)
    |> stream(:asic_miner_not_activated_list, asic_miner_not_activated_list)
    |> assign(:aggregated_coin_hashrate_map, aggregated_coin_hashrate_map)
    |> assign(:aggregated_total_power, aggregated_total_power)
    |> assign(:aggregated_total_power_uom, nil)
    |> assign(:aggregated_asic_miner_alive, aggregated_asic_miner_alive)

    {:ok, new_socket}
  end

  @impl true
  def handle_info({MiningRigMonitorWeb.AsicMinerLive.FormComponent, {:saved, asic_miner}}, socket) do
    {:noreply, stream_insert(socket, :asic_miners, asic_miner)}
  end

  @impl true
  def handle_info({:asic_miner_index_channel, :create_or_update, asic_miner}, socket) do
    # asic_miner's activated can only go from false to true stage.
    case asic_miner.activated do
      true ->
        asic_miner_mod = %{
        id: asic_miner.id,
        name: asic_miner.name,
        model: asic_miner.model,
        model_variant: asic_miner.model_variant,
        asic_expected_status: asic_miner.asic_expected_status,
        light_expected_status: asic_miner.light_expected_status,

        hashrate_5_min: "Sync...",
        hashrate_30_min: "Sync...",
        coin: "Sync...",
        power: "Sync...",
        max_hashboard_temp: "Sync...",
        max_fan: "Sync...",
        uptime: "Sync...",
        uptime_class: "badge badge-info"
        }



        socket_mod = socket
        |> stream_insert(:asic_miner_activated_list, asic_miner_mod)
        |> stream_delete(:asic_miner_not_activated_list, asic_miner)
        {:noreply, socket_mod}
      false ->
        socket_mod = socket
        |> stream_insert(:asic_miner_not_activated_list, asic_miner)
        {:noreply, socket_mod}
    end
  end

  @impl true
  def handle_info({:asic_miner_index_channel, :delete, asic_miner}, socket) do
    socket_mod = socket
    |> stream_delete(:asic_miner_activated_list, asic_miner)
    |> stream_delete(:asic_miner_not_activated_list, asic_miner)
    {:noreply, socket_mod}
  end


  @impl true
  def handle_info({:flash_index, flash_type, message}, socket) do
    socket_mod = put_flash(socket, flash_type, message)
    {:noreply, socket_mod}
  end

  @impl true
  def handle_info({:asic_miner_index_operational_channel , :operational_data, data}, socket) do
    asic_miner_map = Map.get(data, :asic_miner_map)
    asic_miner_operational_map = Map.get(data, :asic_miner_operational_map)
    asic_miner_activated_list = get_asic_miner_activated_list(asic_miner_map, asic_miner_operational_map)

    aggregated_coin_hashrate_map = Map.get(data, :asic_miner_aggregated_index)
    |> Map.get(:coin_hashrate_map)
    |> Enum.reduce(%{}, fn({e_key, e_value}, a) ->
      Map.put(a, e_key, Utility.beautify_hashrate(e_value))
    end)

    aggregated_total_power = Map.get(data, :asic_miner_aggregated_index)
    |> Map.get(:total_power)

    {aggregated_total_power, aggregated_total_power_uom} = Utility.beautify_power_walt({aggregated_total_power, "W"})


    aggregated_asic_miner_alive = Map.get(data, :asic_miner_aggregated_index)
    |> Map.get(:asic_miner_alive)

    new_socket = socket
    |> assign(:aggregated_coin_hashrate_map, aggregated_coin_hashrate_map)
    |> assign(:aggregated_total_power, aggregated_total_power)
    |> assign(:aggregated_total_power_uom, aggregated_total_power_uom)
    |> assign(:aggregated_asic_miner_alive, aggregated_asic_miner_alive)
    |> stream(:asic_miner_activated_list, asic_miner_activated_list)

    {:noreply, new_socket}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    asic_miner = AsicMiners.get_asic_miner!(id)
    {:ok, _} = AsicMiners.delete_asic_miner(asic_miner)
    Phoenix.PubSub.broadcast(MiningRigMonitor.PubSub, "asic_miner_index_channel", {:asic_miner_index_channel, :delete, asic_miner})
    Phoenix.PubSub.broadcast(MiningRigMonitor.PubSub, "flash_index", {:flash_index, :info, "ASIC miner id##{asic_miner.id} name: #{asic_miner.name} deleted"})
    {:noreply, socket}
  end

  @impl true
  def handle_event("toggle_asic", %{"id" => id}, socket) do
    asic_miner = AsicMiners.get_asic_miner!(id)
    asic_expected_status = asic_miner.asic_expected_status

    asic_expected_status_mod = if(asic_expected_status == "on", do: "off", else: "on")

    {:ok, asic_miner} = AsicMiners.update_asic_miner_by_commander(asic_miner, %{asic_expected_status: asic_expected_status_mod})

    Phoenix.PubSub.broadcast(MiningRigMonitor.PubSub, "asic_miner_index_channel",
      {:asic_miner_index_channel, :create_or_update, asic_miner})
    Phoenix.PubSub.broadcast(MiningRigMonitor.PubSub, "asic_miner_channel:#{asic_miner.id}",
      {:asic_miner_channel, :update_asic_miner, asic_miner})
    message =
      case asic_expected_status_mod do
        "on" -> "ASIC miner id##{asic_miner.id} name: #{asic_miner.name} Turn On!"
        _ -> "ASIC miner id##{asic_miner.id} name: #{asic_miner.name} Turn Off!"
      end
    Phoenix.PubSub.broadcast(MiningRigMonitor.PubSub, "flash_index",
      {:flash_index, :info, message})

    {:noreply, socket}
  end

  def get_asic_miner_activated_list(asic_miner_map, asic_miner_operational_map) do
    Enum.map(asic_miner_map, fn({asic_miner_id, asic_miner}) ->
      asic_miner_log = Map.get(asic_miner_operational_map, asic_miner_id, %{})
      beautify_activated_asic_miner(asic_miner, asic_miner_log)
    end)
  end

  def beautify_activated_asic_miner(%AsicMiner{} = asic_miner, %{}=asic_miner_log) do
    coin = Map.get(asic_miner_log, :coin_name, "----") |> String.downcase() |> String.capitalize()

    hashrate_5_min =
    if Kernel.is_nil(Map.get(asic_miner_log, :hashrate_5_min, nil)) do
      "----"
    else
      "#{Kernel.round(asic_miner_log.hashrate_5_min)} #{asic_miner_log.hashrate_uom}"
    end

    hashrate_30_min =
    if Kernel.is_nil(Map.get(asic_miner_log, :hashrate_30_min, nil)) do
      "----"
    else
      "#{Kernel.round(asic_miner_log.hashrate_30_min)} #{asic_miner_log.hashrate_uom}"
    end

    power =
    if Kernel.is_nil(Map.get(asic_miner_log, :power, nil)) do
      "----"
    else
        "#{Map.get(asic_miner_log, :power)} Walt"
    end

    max_fan = [Map.get(asic_miner_log, :fan_1_speed, nil),
               Map.get(asic_miner_log, :fan_2_speed, nil),
               Map.get(asic_miner_log, :fan_3_speed, nil),
               Map.get(asic_miner_log, :fan_4_speed, nil)]
               |> Enum.max()
    max_fan_mod = if Kernel.is_nil(max_fan), do: "----", else: "#{max_fan} RPM"

    max_hashboard_temp = [Map.get(asic_miner_log,  :hashboard_1_temp_1, nil),
                          Map.get(asic_miner_log,  :hashboard_1_temp_2, nil),
                          Map.get(asic_miner_log,  :hashboard_2_temp_1, nil),
                          Map.get(asic_miner_log,  :hashboard_2_temp_2, nil),
                          Map.get(asic_miner_log,  :hashboard_3_temp_1, nil),
                          Map.get(asic_miner_log,  :hashboard_3_temp_2, nil)]
                          |> Enum.max()
    max_hashboard_temp_mod = if Kernel.is_nil(max_hashboard_temp), do: "----", else: "#{max_hashboard_temp} ℃"


    {uptime, uptime_class} =
    if Kernel.is_nil(Map.get(asic_miner_log, :uptime, nil)) do
      {"OFFLINE", "badge badge-error"}
    else
      [e1, e2, e3, _e4] = String.split(asic_miner_log.uptime, ":")
      {"#{e1} days, #{e2} hours, #{e3} minutes", "badge badge-success"}
    end





    %{
      id: asic_miner.id,
      name: asic_miner.name,
      model: asic_miner.model,
      model_variant: asic_miner.model_variant,
      asic_expected_status: asic_miner.asic_expected_status,
      light_expected_status: asic_miner.light_expected_status,
      hashrate_5_min: hashrate_5_min,
      hashrate_30_min: hashrate_30_min,
      coin: coin,
      power: power,
      max_hashboard_temp: max_hashboard_temp_mod,
      max_fan: max_fan_mod,
      uptime: uptime,
      uptime_class: uptime_class
      }
  end
end
