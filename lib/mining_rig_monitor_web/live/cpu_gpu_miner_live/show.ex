defmodule MiningRigMonitorWeb.CpuGpuMinerLive.Show do
  use MiningRigMonitorWeb, :live_view

  alias MiningRigMonitor.CpuGpuMiners

  embed_templates "show_html/*"

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:cpu_gpu_miner, CpuGpuMiners.get_cpu_gpu_miner!(id))}
  end

  defp page_title(:show), do: "Show CPU/GPU miner"
  defp page_title(:edit), do: "Edit CPU/GPU miner"
end
