defmodule MiningRigMonitorWeb.MiningRigLive.ShowAsic do
  use MiningRigMonitorWeb, :live_view

  alias MiningRigMonitor.MiningRigs
  alias MiningRigMonitor.AsicRigMonitorRecords

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    mining_rig = MiningRigs.get_mining_rig!(id)
    latest_asic_monitor_record = AsicRigMonitorRecords.get_latest_asic_monitor_record(id)

    new_socket = socket
    |> assign(:mining_rig, mining_rig)
    |> assign(:latest_asic_monitor_record, latest_asic_monitor_record)

    {:noreply, new_socket}
  end
end
