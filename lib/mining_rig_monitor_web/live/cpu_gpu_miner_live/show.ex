defmodule MiningRigMonitorWeb.CpuGpuMinerLive.Show do
  use MiningRigMonitorWeb, :live_view

  alias MiningRigMonitor.CpuGpuMiners

  embed_templates "show_html/*"

  @impl true
  def mount(%{"id" => cpu_gpu_miner_id}, _session, socket) do
    cpu_gpu_miner = CpuGpuMiners.get_cpu_gpu_miner!(cpu_gpu_miner_id)
    cpu_gpu_miner_log = empty_cpu_gpu_miner_log()

    if connected?(socket) do
      Phoenix.PubSub.subscribe(MiningRigMonitor.PubSub, "cpu_gpu_miner_operational_channel:#{cpu_gpu_miner.id}")
    end

    socket_mod = socket
    |> assign(:page_title, "Miner: #{cpu_gpu_miner.name}")
    |> assign(:cpu_gpu_miner, cpu_gpu_miner)
    |> assign(:cpu_gpu_miner_log, cpu_gpu_miner_log)
    {:ok, socket_mod}
  end

  @imple true
  def handle_info({:cpu_gpu_miner_operational_channel , :create_cpu_gpu_miner_log, cpu_gpu_miner_log}, socket) do
    socket_mod = socket
    |> assign(:cpu_gpu_miner_log, cpu_gpu_miner_log)
    {:noreply, socket_mod}
  end

  # @impl true
  # def handle_params(%{"id" => id}, _, socket) do
  #   {:noreply,
  #    socket
  #    |> assign(:page_title, page_title(socket.assigns.live_action))
  #    |> assign(:cpu_gpu_miner, CpuGpuMiners.get_cpu_gpu_miner!(id))}
  # end

  def empty_cpu_gpu_miner_log() do
    %MiningRigMonitor.CpuGpuMinerLogs.CpuGpuMinerLog{}
    |> Map.put(:cpu_temp, nil)
    |> Map.put(:cpu_hashrate, nil)
    |> Map.put(:cpu_hashrate_uom, "----")
    |> Map.put(:cpu_algorithm, "----")
    |> Map.put(:cpu_coin_name, "----")
  end
end
