defmodule MiningRigMonitorWeb.AsicMinerLive.Index do
  use MiningRigMonitorWeb, :live_view

  alias MiningRigMonitor.AsicMiners
  alias MiningRigMonitor.AsicMiners.AsicMiner
  alias MiningRigMonitor.GenServer.AsicMinerOperationalIndex
  alias MiningRigMonitor.AsicMinerLogs.AsicMinerLog

  embed_templates "index_html/*"

  @impl true
  def mount(_params, _session, socket) do
    asic_miner_activated_list = get_asic_miner_activated_list_with_log()
    asic_miner_not_activated_list = AsicMiners.list_asic_miners_by_activated_state(false)

    new_socket = socket
    |> stream(:asic_miner_activated_list, asic_miner_activated_list)
    |> stream(:asic_miner_not_activated_list, asic_miner_not_activated_list)

    Phoenix.PubSub.subscribe(MiningRigMonitor.PubSub, "asic_miner_index")
    Phoenix.PubSub.subscribe(MiningRigMonitor.PubSub, "flash_index")

    {:ok, new_socket}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit ASIC miner")
    |> assign(:asic_miner, AsicMiners.get_asic_miner!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New ASIC miner")
    |> assign(:asic_miner, %AsicMiner{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing ASIC miners")
    |> assign(:asic_miner, nil)
  end

  def get_asic_miner_activated_list_with_log() do
    asic_miner_activated_list = AsicMiners.list_asic_miners_by_activated_state(true)
    asic_miner_activated_id_list = Enum.map(asic_miner_activated_list, &(&1.id))
    asic_miner_log_map = AsicMinerOperationalIndex.take(asic_miner_activated_id_list)

    Enum.map(asic_miner_activated_list, fn(e) ->
      asic_miner_log = Map.get(asic_miner_log_map, e.id, %{})
      coin = Map.get(asic_miner_log, :coin_name, "----")
      hashrate = "#{Map.get(asic_miner_log, :hashrate_5_min, "----")} #{Map.get(asic_miner_log, :hashrate_uom, nil)}"
      power = Map.get(asic_miner_log, :power, nil)

      max_fan = [Map.get(asic_miner_log, :fan_1_speed, nil),
                 Map.get(asic_miner_log, :fan_2_speed, nil),
                 Map.get(asic_miner_log, :fan_3_speed, nil),
                 Map.get(asic_miner_log, :fan_4_speed, nil)]
                 |> Enum.max()

      max_hashboard_temp = [Map.get(asic_miner_log,  :hashboard_1_temp_1, nil),
                            Map.get(asic_miner_log,  :hashboard_1_temp_2, nil),
                            Map.get(asic_miner_log,  :hashboard_2_temp_1, nil),
                            Map.get(asic_miner_log,  :hashboard_2_temp_2, nil),
                            Map.get(asic_miner_log,  :hashboard_3_temp_1, nil),
                            Map.get(asic_miner_log,  :hashboard_3_temp_2, nil)]
                            |> Enum.max()


      uptime =
      if Kernel.is_nil(Map.get(asic_miner_log, :uptime, nil)) do
        "OFFLINE"
      else
        [e1, e2, e3, _e4] = String.split(asic_miner_log.uptime, ":")
        "#{e1} days, #{e2} hours, #{e3} minutes"
      end
      %{
        id: e.id,
        name: e.name,
        hashrate: hashrate,
        coin: coin,
        power: power,
        max_hashboard_temp: max_hashboard_temp,
        max_fan: max_fan,
        uptime: uptime
      }
    end)
  end

  def get_asic_miner_activated_with_log(asic_miner) do
    asic_miner_log =
      case AsicMinerOperationalIndex.get(asic_miner.id) do
        nil -> %{}
        %AsicMinerLog{}=log -> log
      end


    coin = Map.get(asic_miner_log, :coin_name, "----")
    hashrate =
    if Kernel.is_nil(Map.get(asic_miner_log, :hashrate_5_min, nil)) do
      "----"
    else
      "#{Kernel.round(asic_miner_log.hashrate_5_min)} #{asic_miner_log.hashrate_uom}"
    end


    power = Map.get(asic_miner_log, :power, nil)

    max_fan = [Map.get(asic_miner_log, :fan_1_speed, nil),
               Map.get(asic_miner_log, :fan_2_speed, nil),
               Map.get(asic_miner_log, :fan_3_speed, nil),
               Map.get(asic_miner_log, :fan_4_speed, nil)]
               |> Enum.max()

    max_hashboard_temp = [Map.get(asic_miner_log,  :hashboard_1_temp_1, nil),
                          Map.get(asic_miner_log,  :hashboard_1_temp_2, nil),
                          Map.get(asic_miner_log,  :hashboard_2_temp_1, nil),
                          Map.get(asic_miner_log,  :hashboard_2_temp_2, nil),
                          Map.get(asic_miner_log,  :hashboard_3_temp_1, nil),
                          Map.get(asic_miner_log,  :hashboard_3_temp_2, nil)]
                          |> Enum.max()

    uptime =
    if Kernel.is_nil(Map.get(asic_miner_log, :uptime, nil)) do
      "OFFLINE"
    else
      [e1, e2, e3, _e4] = String.split(asic_miner_log.uptime, ":")
      "#{e1} days, #{e2} hours, #{e3} minutes"
    end
    %{
      id: asic_miner.id,
      name: asic_miner.name,
      hashrate: hashrate,
      coin: coin,
      power: power,
      max_hashboard_temp: max_hashboard_temp,
      max_fan: max_fan,
      uptime: uptime
    }
  end

  @impl true
  def handle_info({MiningRigMonitorWeb.AsicMinerLive.FormComponent, {:saved, asic_miner}}, socket) do
    {:noreply, stream_insert(socket, :asic_miners, asic_miner)}
  end

  @impl true
  def handle_info({:asic_miner_index, :create_or_update, asic_miner}, socket) do
    case asic_miner.activated do
      true ->
        asic_miner_activated_with_log = get_asic_miner_activated_with_log(asic_miner)

        socket_mod = socket
        |> stream_insert(:asic_miner_activated_list, asic_miner_activated_with_log)
        {:noreply, socket_mod}
      false ->
        socket_mod = socket
        |> stream_insert(:asic_miner_not_activated_list, asic_miner)
        {:noreply, socket_mod}
    end
  end

  @impl true
  def handle_info({:asic_miner_index, :delete, asic_miner}, socket) do
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
  def handle_event("delete", %{"id" => id}, socket) do
    asic_miner = AsicMiners.get_asic_miner!(id)
    {:ok, _} = AsicMiners.delete_asic_miner(asic_miner)
    Phoenix.PubSub.broadcast(MiningRigMonitor.PubSub, "asic_miner_index", {:asic_miner_index, :delete, asic_miner})
    Phoenix.PubSub.broadcast(MiningRigMonitor.PubSub, "flash_index", {:flash_index, :info, "ASIC miner id##{asic_miner.id} name: #{asic_miner.name} deleted"})
    {:noreply, socket}
  end
end
