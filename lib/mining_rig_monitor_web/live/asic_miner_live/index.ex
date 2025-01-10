defmodule MiningRigMonitorWeb.AsicMinerLive.Index do
  use MiningRigMonitorWeb, :live_view

  alias MiningRigMonitor.AsicMiners
  alias MiningRigMonitor.AsicMiners.AsicMiner

  embed_templates "index_html/*"

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :asic_miners, AsicMiners.list_asic_miners())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Asic miner")
    |> assign(:asic_miner, AsicMiners.get_asic_miner!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Asic miner")
    |> assign(:asic_miner, %AsicMiner{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Asic miners")
    |> assign(:asic_miner, nil)
  end

  @impl true
  def handle_info({MiningRigMonitorWeb.AsicMinerLive.FormComponent, {:saved, asic_miner}}, socket) do
    {:noreply, stream_insert(socket, :asic_miners, asic_miner)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    asic_miner = AsicMiners.get_asic_miner!(id)
    {:ok, _} = AsicMiners.delete_asic_miner(asic_miner)

    {:noreply, stream_delete(socket, :asic_miners, asic_miner)}
  end
end
