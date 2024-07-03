defmodule MiningRigMonitorWeb.MiningRigLive.Show do
  use MiningRigMonitorWeb, :live_view

  alias MiningRigMonitor.MiningRigs

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:mining_rig, MiningRigs.get_mining_rig!(id))}
  end

  defp page_title(:show), do: "Show Mining rig"
  defp page_title(:edit), do: "Edit Mining rig"
end
