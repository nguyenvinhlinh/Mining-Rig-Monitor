defmodule MiningRigMonitorWeb.CpuGpuMinerPlaybookLive.Show do
  use MiningRigMonitorWeb, :live_view

  alias MiningRigMonitor.CpuGpuMinerPlaybooks

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"playbook_id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:cpu_gpu_miner_playbook, CpuGpuMinerPlaybooks.get_cpu_gpu_miner_playbook!(id))}
  end

  defp page_title(:show), do: "Show CPU/GPU miner playbook"
end
