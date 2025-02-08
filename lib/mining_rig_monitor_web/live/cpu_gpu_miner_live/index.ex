defmodule MiningRigMonitorWeb.CpuGpuMinerLive.Index do
  use MiningRigMonitorWeb, :live_view

  alias MiningRigMonitor.CpuGpuMiners
  alias MiningRigMonitor.CpuGpuMiners.CpuGpuMiner

  embed_templates "index_html/*"

  @impl true
  def mount(_params, _session, socket) do
    cpu_gpu_miner_not_activated_list = CpuGpuMiners.list_cpu_gpu_miners_by_activated_state(false)
    cpu_gpu_miner_activated_list = CpuGpuMiners.list_cpu_gpu_miners_by_activated_state(true)

    socket_mod = socket
    |> stream(:cpu_gpu_miner_not_activated_list, cpu_gpu_miner_not_activated_list)
    |> stream(:cpu_gpu_miner_activated_list, cpu_gpu_miner_activated_list)

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
  def handle_info({MiningRigMonitorWeb.CpuGpuMinerLive.FormComponent, {:saved, cpu_gpu_miner}}, socket) do
    {:noreply, stream_insert(socket, :cpu_gpu_miners, cpu_gpu_miner)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    cpu_gpu_miner = CpuGpuMiners.get_cpu_gpu_miner!(id)
    {:ok, _} = CpuGpuMiners.delete_cpu_gpu_miner(cpu_gpu_miner)

    {:noreply, stream_delete(socket, :cpu_gpu_miners, cpu_gpu_miner)}
  end
end
