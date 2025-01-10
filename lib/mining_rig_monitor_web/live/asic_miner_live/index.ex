defmodule MiningRigMonitorWeb.AsicMinerLive.Index do
  use MiningRigMonitorWeb, :live_view

  alias MiningRigMonitor.AsicMiners
  alias MiningRigMonitor.AsicMiners.AsicMiner

  embed_templates "index_html/*"

  @impl true
  def mount(_params, _session, socket) do
    asic_miner_activated_list = AsicMiners.list_asic_miners_by_activated_state(true)
    asic_miner_not_activated_list = AsicMiners.list_asic_miners_by_activated_state(false)

    new_socket = socket
    |> stream(:asic_miner_activated_list, asic_miner_activated_list)
    |> stream(:asic_miner_not_activated_list, asic_miner_not_activated_list)

    Phoenix.PubSub.subscribe(MiningRigMonitor.PubSub, "asic_miner_index")
    Phoenix.PubSub.subscribe(MiningRigMonitor.PubSub, "flash_index")

    {:ok, new_socket}
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
    |> assign(:page_title, "New ASIC miner")
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
  def handle_info({:asic_miner_index, :create_or_update, asic_miner}, socket) do
    case asic_miner.activated do
      true ->
        socket_mod = socket
        |> stream_insert(:asic_miner_activated_list, asic_miner)
        {:noreply, socket_mod}
      false ->
        socket_mod = socket
        |> stream_insert(:asic_miner_not_activated_list, asic_miner)
        {:noreply, socket_mod}
    end
  end

  @impl true
  def handle_info({:asic_miner_index, :delete, asic_miner}, socket) do
    socket_mod = socket
    |> stream_delete(:asic_miner_activated_list, asic_miner)
    |> stream_delete(:asic_miner_not_activated_list, asic_miner)
    {:noreply, socket_mod}
  end


  @impl true
  def handle_info({:flash_index, flash_type, message}, socket) do
    socket_mod = put_flash(socket, flash_type, message)
    {:noreply, socket_mod}
  end
  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    asic_miner = AsicMiners.get_asic_miner!(id)
    {:ok, _} = AsicMiners.delete_asic_miner(asic_miner)
    Phoenix.PubSub.broadcast(MiningRigMonitor.PubSub, "asic_miner_index", {:asic_miner_index, :delete, asic_miner})
    Phoenix.PubSub.broadcast(MiningRigMonitor.PubSub, "flash_index", {:flash_index, :info, "ASIC miner id##{asic_miner.id} name: #{asic_miner.name} deleted"})
    {:noreply, socket}
  end
end
