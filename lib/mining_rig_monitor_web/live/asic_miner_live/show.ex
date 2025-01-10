defmodule MiningRigMonitorWeb.AsicMinerLive.Show do
  use MiningRigMonitorWeb, :live_view

  alias MiningRigMonitor.AsicMiners

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:asic_miner, AsicMiners.get_asic_miner!(id))}
  end

  defp page_title(:show), do: "Show Asic miner"
  defp page_title(:edit), do: "Edit Asic miner"
end
