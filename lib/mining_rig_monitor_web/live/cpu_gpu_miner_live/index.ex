defmodule MiningRigMonitorWeb.CpuGpuMinerLive.Index do
  use MiningRigMonitorWeb, :live_view

  alias MiningRigMonitor.CpuGpuMiners
  alias MiningRigMonitor.CpuGpuMiners.CpuGpuMiner
  alias MiningRigMonitor.CpuGpuMinerLogs.CpuGpuMinerLog
  alias MiningRigMonitor.Utility

  embed_templates "index_html/*"

  @impl true
  def mount(_params, _session, socket) do
    cpu_gpu_miner_not_activated_list = CpuGpuMiners.list_cpu_gpu_miners_by_activated_state(false)
    cpu_gpu_miner_activated_list = CpuGpuMiners.list_cpu_gpu_miners_by_activated_state(true)
    |> Enum.map(fn(e) ->
      %{
        id: e.id,
        name: e.name,
        cpu_coin_name: "SYNC...",
        gpu_coin_name_1: nil,
        gpu_coin_name_2: nil,

        cpu_hashrate: "SYNC...",
        cpu_hashrate_uom: nil,
        cpu_algorithm: nil,

        gpu_algorithm_1: nil,
        gpu_hashrate_1: nil,
        gpu_hashrate_uom_1: nil,

        gpu_algorithm_2: nil,
        gpu_hashrate_2: nil,
        gpu_hashrate_uom_2: nil,

        cpu_temp: "SYNC...",
        max_gpu_core_temp: "SYNC...",
        max_gpu_mem_temp: "SYNC...",
        max_gpu_fan: "SYNC...",
        gpu_fan_uom: nil,

        total_power: "SYNC...",
        uptime: "SYNC..." }
    end)

    cpu_gpu_miner_alive = "Sync..."
    aggregated_total_power = "Sync..."

    socket_mod = socket
    |> stream(:cpu_gpu_miner_not_activated_list, cpu_gpu_miner_not_activated_list)
    |> stream(:cpu_gpu_miner_activated_list, cpu_gpu_miner_activated_list)
    |> assign(:cpu_gpu_miner_alive, cpu_gpu_miner_alive)
    |> assign(:aggregated_total_power, aggregated_total_power)
    |> assign(:aggregated_total_power_uom, nil)
    |> assign(:aggregated_coin_hashrate_map, %{})

    if connected?(socket) do
      Phoenix.PubSub.subscribe(MiningRigMonitor.PubSub, "cpu_gpu_miner_index_channel")
      Phoenix.PubSub.subscribe(MiningRigMonitor.PubSub, "cpu_gpu_miner_index_operational_channel")
      Phoenix.PubSub.subscribe(MiningRigMonitor.PubSub, "flash_index")
    end

    {:ok, socket_mod}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit CPU/GPU miner")
    |> assign(:cpu_gpu_miner, CpuGpuMiners.get_cpu_gpu_miner!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New CPU/GPU miner")
    |> assign(:cpu_gpu_miner, %CpuGpuMiner{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "CPU/GPU miner index")
    |> assign(:cpu_gpu_miner, nil)
  end

  @impl true
  def handle_info({:cpu_gpu_miner_index_channel, :create_or_update, cpu_gpu_miner}, socket) do
    case cpu_gpu_miner.activated  do
      true ->
        cpu_gpu_miner_mod =
          %{
            id: cpu_gpu_miner.id,
            name: cpu_gpu_miner.name,
            cpu_coin_name: "SYNC...",
            gpu_coin_name_1: nil,
            gpu_coin_name_2: nil,

            cpu_hashrate: "SYNC...",
            cpu_hashrate_uom: nil,
            cpu_algorithm: nil,

            gpu_algorithm_1: nil,
            gpu_hashrate_1: nil,
            gpu_hashrate_uom_1: nil,

            gpu_algorithm_2: nil,
            gpu_hashrate_2: nil,
            gpu_hashrate_uom_2: nil,

            cpu_temp: "SYNC...",
            max_gpu_core_temp: "SYNC...",
            max_gpu_mem_temp: "SYNC...",
            max_gpu_fan: "SYNC...",
            gpu_fan_uom: nil,

            total_power: "SYNC...",
            uptime: "SYNC..."
          }

        socket_mod = socket
        |> stream_insert(:cpu_gpu_miner_activated_list, cpu_gpu_miner_mod)
        |> stream_delete(:cpu_gpu_miner_not_activated_list, cpu_gpu_miner)
        {:noreply, socket_mod}
      false ->
        socket_mod = socket
        |> stream_insert(:cpu_gpu_miner_not_activated_list, cpu_gpu_miner)
        |> stream_delete(:cpu_gpu_miner_activated_list, cpu_gpu_miner)
        {:noreply, socket_mod}
    end
  end

  @impl true
  def handle_info({:cpu_gpu_miner_index_channel, :delete, cpu_gpu_miner}, socket) do
    socket_mod = socket
    |> stream_delete(:cpu_gpu_miner_not_activated_list, cpu_gpu_miner)
    |> stream_delete(:cpu_gpu_miner_activated_list,     cpu_gpu_miner)
    {:noreply, socket_mod}
  end

  @impl true
  def handle_info({:cpu_gpu_miner_index_operational_channel, :operational_data, data}, socket) do
    cpu_gpu_miner_map = Map.get(data, :cpu_gpu_miner_map)
    cpu_gpu_miner_operational_map = Map.get(data, :cpu_gpu_miner_operational_map)
    cpu_gpu_miner_activated_list = get_cpu_gpu_miner_activated_list(cpu_gpu_miner_map, cpu_gpu_miner_operational_map)

    aggregated_total_power = data
    |> Map.get(:aggregated_index)
    |> Map.get(:total_power)

    {aggregated_total_power, aggregated_total_power_uom} = Utility.beautify_power_walt({aggregated_total_power, "W"})


    cpu_gpu_miner_alive = data
    |> Map.get(:aggregated_index)
    |> Map.get(:cpu_gpu_miner_alive)

    aggregated_coin_hashrate_map = data
    |> Map.get(:aggregated_index)
    |> Map.get(:coin_hashrate_map)

    socket_mod = socket
    |> stream(:cpu_gpu_miner_activated_list, cpu_gpu_miner_activated_list)
    |> assign(:aggregated_total_power, aggregated_total_power)
    |> assign(:aggregated_total_power_uom, aggregated_total_power_uom)
    |> assign(:cpu_gpu_miner_alive, cpu_gpu_miner_alive)
    |> assign(:aggregated_coin_hashrate_map, aggregated_coin_hashrate_map)

    {:noreply, socket_mod}
  end

  @impl true
  def handle_info({:flash_index, flash_type, message}, socket) do
    socket_mod = put_flash(socket, flash_type, message)
    {:noreply, socket_mod}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    cpu_gpu_miner = CpuGpuMiners.get_cpu_gpu_miner!(id)
    {:ok, _} = CpuGpuMiners.delete_cpu_gpu_miner(cpu_gpu_miner)
    Phoenix.PubSub.broadcast(MiningRigMonitor.PubSub, "cpu_gpu_miner_index_channel", {:cpu_gpu_miner_index_channel, :delete, cpu_gpu_miner})

    Phoenix.PubSub.broadcast(MiningRigMonitor.PubSub, "cpu_gpu_miner_channel:#{cpu_gpu_miner.id}", {:cpu_gpu_miner_channel, :delete, cpu_gpu_miner})

    Phoenix.PubSub.broadcast(MiningRigMonitor.PubSub, "flash_index", {:flash_index, :info, "CPU/GPU miner id##{cpu_gpu_miner.id} name: #{cpu_gpu_miner.name} deleted!"})
    {:noreply, socket}
  end

  def get_cpu_gpu_miner_activated_list(cpu_gpu_miner_map, cpu_gpu_miner_operational_map) do
    Enum.map(cpu_gpu_miner_map, fn({cpu_gpu_miner_id, cpu_gpu_miner}) ->

      cpu_gpu_miner_log = Map.get(cpu_gpu_miner_operational_map, cpu_gpu_miner_id, nil)
      beautify_activated_cpu_gpu_miner(cpu_gpu_miner, cpu_gpu_miner_log)
    end)
  end

  def beautify_activated_cpu_gpu_miner(%CpuGpuMiner{} = cpu_gpu_miner, nil) do
    %{
      id: cpu_gpu_miner.id,
      name: cpu_gpu_miner.name,
      cpu_coin_name: "----",
      gpu_coin_name_1: nil,
      gpu_coin_name_2: nil,

      cpu_hashrate: "----",
      cpu_hashrate_uom: nil,
      cpu_algorithm: nil,

      gpu_algorithm_1: nil,
      gpu_hashrate_1: nil,
      gpu_hashrate_uom_1: nil,

      gpu_algorithm_2: nil,
      gpu_hashrate_2: nil,
      gpu_hashrate_uom_2: nil,

      cpu_temp: "----",
      max_gpu_core_temp: "----",
      max_gpu_mem_temp: "----",
      max_gpu_fan: "----",
      gpu_fan_uom: nil,

      total_power: "----",
      uptime: "OFFLINE"
    }
  end
  def beautify_activated_cpu_gpu_miner(%CpuGpuMiner{} = cpu_gpu_miner, %CpuGpuMinerLog{} = cpu_gpu_miner_log) do
    gpu_hashrate_1 = CpuGpuMinerLog.sum_gpu_hashrate_1(cpu_gpu_miner_log)
    gpu_hashrate_2 = CpuGpuMinerLog.sum_gpu_hashrate_2(cpu_gpu_miner_log)

    max_gpu_core_temp = CpuGpuMinerLog.find_max_gpu_core_temp(cpu_gpu_miner_log)
    max_gpu_mem_temp =  CpuGpuMinerLog.find_max_gpu_mem_temp(cpu_gpu_miner_log)
    max_gpu_fan =       CpuGpuMinerLog.find_max_gpu_fan_speed(cpu_gpu_miner_log)

    total_power = CpuGpuMinerLog.sum_total_power(cpu_gpu_miner_log)
    uptime = MiningRigMonitor.Utility.beautify_uptime(cpu_gpu_miner_log.uptime)

    %{
      id: cpu_gpu_miner.id,
      name: cpu_gpu_miner.name,

      cpu_coin_name:    cpu_gpu_miner_log.cpu_coin_name,
      cpu_algorithm:    cpu_gpu_miner_log.cpu_algorithm,
      cpu_hashrate:     cpu_gpu_miner_log.cpu_hashrate,
      cpu_hashrate_uom: cpu_gpu_miner_log.cpu_hashrate_uom,

      gpu_coin_name_1: cpu_gpu_miner_log.gpu_coin_name_1,
      gpu_algorithm_1: cpu_gpu_miner_log.gpu_algorithm_1,
      gpu_hashrate_1:  gpu_hashrate_1,
      gpu_hashrate_uom_1: cpu_gpu_miner_log.gpu_hashrate_uom_1,

      gpu_coin_name_2: cpu_gpu_miner_log.gpu_coin_name_2,
      gpu_algorithm_2: cpu_gpu_miner_log.gpu_algorithm_2,
      gpu_hashrate_2:  gpu_hashrate_2,
      gpu_hashrate_uom_2: cpu_gpu_miner_log.gpu_hashrate_uom_2,

      cpu_temp: "#{cpu_gpu_miner_log.cpu_temp} ℃",
      max_gpu_core_temp: "#{max_gpu_core_temp} ℃",
      max_gpu_mem_temp: "#{max_gpu_mem_temp} ℃",
      max_gpu_fan: max_gpu_fan,
      gpu_fan_uom: cpu_gpu_miner_log.gpu_fan_uom,
      total_power: "#{total_power} W",
      uptime: uptime
    }
  end
end
