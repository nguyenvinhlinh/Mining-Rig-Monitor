defmodule MiningRigMonitorWeb.MiningRigLive.ShowAsic do
  use MiningRigMonitorWeb, :live_view

  alias MiningRigMonitor.MiningRigs
  alias MiningRigMonitor.AsicRigMonitorRecords

  @impl true
  def mount(%{"id" => mining_rig_id}, _session, socket) do
    mining_rig = MiningRigs.get_mining_rig!(mining_rig_id)
    latest_asic_monitor_record = AsicRigMonitorRecords.get_latest_asic_monitor_record(mining_rig_id)

    if connected?(socket) do
      asic_rig_monitor_record_topic = "asic_rig_monitor_record:#{mining_rig.id}"
      mining_rig_topic = "mining_rig:#{mining_rig.id}"
      Phoenix.PubSub.subscribe(MiningRigMonitor.PubSub, asic_rig_monitor_record_topic)
      Phoenix.PubSub.subscribe(MiningRigMonitor.PubSub, mining_rig_topic)
    end

    new_socket = socket
    |> assign(:mining_rig, mining_rig)
    |> assign(:latest_asic_monitor_record, latest_asic_monitor_record)

    {:ok, new_socket}
  end

  def handle_info({:mining_rig_updated, mining_rig}, socket) do
    new_socket =
      socket
      |> assign(:mining_rig, mining_rig)
    {:noreply, new_socket}
  end

  @impl true
  def handle_info({:asic_rig_monitor_record_created, asic_rig_monitor_record}, socket) do
    new_socket =
      socket
      |> assign(:latest_asic_monitor_record, asic_rig_monitor_record)

    {:noreply, new_socket}
  end
end
