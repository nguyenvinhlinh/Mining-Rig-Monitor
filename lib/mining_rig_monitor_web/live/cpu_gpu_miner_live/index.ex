defmodule MiningRigMonitorWeb.CpuGpuMinerLive.Index do
  use MiningRigMonitorWeb, :live_view

  alias MiningRigMonitor.CpuGpuMiners
  alias MiningRigMonitor.CpuGpuMiners.CpuGpuMiner

  embed_templates "index_html/*"

  @impl true
  def mount(_params, _session, socket) do
    cpu_gpu_miner_not_activated_list = CpuGpuMiners.list_cpu_gpu_miners_by_activated_state(false)
    cpu_gpu_miner_activated_list =
      CpuGpuMiners.list_cpu_gpu_miners_by_activated_state(true)
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
        gpu_hashrate_uom_2: nil

  }
    end)

    socket_mod = socket
    |> stream(:cpu_gpu_miner_not_activated_list, cpu_gpu_miner_not_activated_list)
    |> stream(:cpu_gpu_miner_activated_list, cpu_gpu_miner_activated_list)

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
        socket_mod = socket
        |> stream_insert(:cpu_gpu_miner_activated_list, cpu_gpu_miner)
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

    socket_mod = socket
    |> stream(:cpu_gpu_miner_activated_list, cpu_gpu_miner_activated_list)

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
    Phoenix.PubSub.broadcast(MiningRigMonitor.PubSub, "flash_index", {:flash_index, :info, "CPU/GPU miner id##{cpu_gpu_miner.id} name: #{cpu_gpu_miner.name} deleted"})
    {:noreply, socket}
  end

  def get_cpu_gpu_miner_activated_list(cpu_gpu_miner_map, cpu_gpu_miner_operational_map) do
    Enum.map(cpu_gpu_miner_map, fn({cpu_gpu_miner_id, cpu_gpu_miner}) ->

      cpu_gpu_miner_log = Map.get(cpu_gpu_miner_operational_map, cpu_gpu_miner_id, %{})
      beautify_activated_cpu_gpu_miner(cpu_gpu_miner, cpu_gpu_miner_log)
    end)
  end

  def beautify_activated_cpu_gpu_miner(%CpuGpuMiner{} = cpu_gpu_miner, %{} = cpu_gpu_miner_log) do
    cpu_coin_name =   Map.get(cpu_gpu_miner_log, :cpu_coin_name, "----") |> String.downcase() |> String.capitalize()
    gpu_coin_name_1 = Map.get(cpu_gpu_miner_log, :gpu_coin_name_1, "----") |> String.downcase() |> String.capitalize()
    gpu_coin_name_2 = Map.get(cpu_gpu_miner_log, :gpu_coin_name_2, "----") |> String.downcase() |> String.capitalize()

    gpu_hashrate_1 = MiningRigMonitorWeb.CpuGpuMinerLive.Show.sum_gpu_hashrate_1(cpu_gpu_miner_log)
    gpu_hashrate_2 = MiningRigMonitorWeb.CpuGpuMinerLive.Show.sum_gpu_hashrate_2(cpu_gpu_miner_log)


    %{
      id: cpu_gpu_miner.id,
      name: cpu_gpu_miner.name,

      cpu_coin_name: cpu_coin_name,
      cpu_algorithm: cpu_gpu_miner_log.cpu_algorithm,
      cpu_hashrate: cpu_gpu_miner_log.cpu_hashrate,
      cpu_hashrate_uom: cpu_gpu_miner_log.cpu_hashrate_uom,

      gpu_coin_name_1: gpu_coin_name_1,
      gpu_algorithm_1: cpu_gpu_miner_log.gpu_algorithm_1,
      gpu_hashrate_1: gpu_hashrate_1,
      gpu_hashrate_uom_1: cpu_gpu_miner_log.gpu_hashrate_uom_1,

      gpu_coin_name_2: cpu_gpu_miner_log.gpu_coin_name_2,
      gpu_algorithm_2: cpu_gpu_miner_log.gpu_algorithm_2,
      gpu_hashrate_2: gpu_hashrate_2,
      gpu_hashrate_uom_2: cpu_gpu_miner_log.gpu_hashrate_uom_2

    }
  end
end
