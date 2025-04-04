defmodule MiningRigMonitorWeb.CpuGpuMinerPlaybookLive.Show do
  use MiningRigMonitorWeb, :live_view

  alias MiningRigMonitor.CpuGpuMinerPlaybooks
  alias  MiningRigMonitor.CpuGpuMiners

  embed_templates "show_html/*"

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"playbook_id" => id}, _, socket) do
    cpu_gpu_miner_playbook = CpuGpuMinerPlaybooks.get_cpu_gpu_miner_playbook!(id)
    cpu_gpu_miner = CpuGpuMiners.get_cpu_gpu_miner!(cpu_gpu_miner_playbook.cpu_gpu_miner_id)
    socket_mod = socket
    |> assign(:page_title, page_title(socket.assigns.live_action))
    |> assign(:cpu_gpu_miner, cpu_gpu_miner)
    |> assign(:cpu_gpu_miner_playbook, cpu_gpu_miner_playbook)
    {:noreply, socket_mod}

    end

  defp page_title(:show), do: "Show CPU/GPU miner playbook"
end
