defmodule MiningRigMonitorWeb.CpuGpuMinerLive.Show do
  use MiningRigMonitorWeb, :live_view

  alias MiningRigMonitor.CpuGpuMiners
  alias MiningRigMonitor.CpuGpuMinerLogs.CpuGpuMinerLog

  embed_templates "show_html/*"

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => cpu_gpu_miner_id}, _uri, socket) do
    case CpuGpuMiners.get_cpu_gpu_miner(cpu_gpu_miner_id) do
      nil ->
        socket_mod = socket
        |> push_navigate(to: ~p(/cpu_gpu_miners))
        |> put_flash(:error, "CPU/GPU Miner id##{cpu_gpu_miner_id} not found! Go to CPU/GPU Miner Index.")
        {:noreply, socket_mod}
      cpu_gpu_miner ->
        if connected?(socket) do
          Phoenix.PubSub.subscribe(MiningRigMonitor.PubSub, "cpu_gpu_miner_channel:#{cpu_gpu_miner.id}")
          Phoenix.PubSub.subscribe(MiningRigMonitor.PubSub, "cpu_gpu_miner_operational_channel:#{cpu_gpu_miner.id}")
        end

        socket_mod = socket
        |> assign(:page_title, "Miner: #{cpu_gpu_miner.name}")
        |> assign(:cpu_gpu_miner, cpu_gpu_miner)
        |> assign(:cpu_gpu_miner_log, empty_cpu_gpu_miner_log())
        {:noreply, socket_mod}
    end
  end

  @impl true
  def handle_info({:cpu_gpu_miner_operational_channel , :create_cpu_gpu_miner_log, cpu_gpu_miner_log}, socket) do
    socket_mod = socket
    |> assign(:cpu_gpu_miner_log, cpu_gpu_miner_log)
    {:noreply, socket_mod}
  end

  @impl true
  def handle_info({:cpu_gpu_miner_channel, :update, cpu_gpu_miner}, socket) do
    socket_mod = socket
    |> assign(:cpu_gpu_miner, cpu_gpu_miner)
    {:noreply, socket_mod}
  end

  @impl true
  def handle_info({:cpu_gpu_miner_channel, :delete, cpu_gpu_miner}, socket) do
    socket_mod = socket
    |> put_flash(:info, "CPU/GPU miner id##{cpu_gpu_miner.id} name: #{cpu_gpu_miner.name} deleted!")
    |> push_navigate(to: ~p(/cpu_gpu_miners))

    {:noreply, socket_mod}
  end

  def empty_cpu_gpu_miner_log() do
    %MiningRigMonitor.CpuGpuMinerLogs.CpuGpuMinerLog{}
  end
end
