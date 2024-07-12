defmodule MiningRigMonitorWeb.MiningRigLive.Index do
  use MiningRigMonitorWeb, :live_view

  alias MiningRigMonitor.MiningRigs
  alias MiningRigMonitor.MiningRigs.MiningRig

  @impl true
  def mount(_params, _session, socket) do
    IO.inspect "DEBUG #{__ENV__.file} @#{__ENV__.line}"
    IO.inspect :mount
    IO.inspect "END"
    {:ok, stream(socket, :mining_rigs, MiningRigs.list_mining_rigs())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit mining rig")
    |> assign(:mining_rig, MiningRigs.get_mining_rig!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "Create new mining rig")
    |> assign(:mining_rig, %MiningRig{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Mining rigs")
    |> assign(:mining_rig, nil)
  end

  defp apply_action(socket, :pre_delete, %{"id" => id}) do
    socket
    |> assign(:page_title, "Delete mining rig")
    |> assign(:mining_rig, MiningRigs.get_mining_rig!(id))
  end



  @impl true
  def handle_info({MiningRigMonitorWeb.MiningRigLive.FormComponent, {:saved, mining_rig}}, socket) do
    {:noreply, stream_insert(socket, :mining_rigs, mining_rig)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    mining_rig = MiningRigs.get_mining_rig!(id)
    {:ok, _} = MiningRigs.delete_mining_rig(mining_rig)

    {:noreply, stream_delete(socket, :mining_rigs, mining_rig)}
  end
end
