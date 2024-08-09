defmodule MiningRigMonitorWeb.AsicRigMonitorRecordController do
  use MiningRigMonitorWeb, :controller

  alias MiningRigMonitor.AsicRigMonitorRecords

  action_fallback MiningRigMonitorWeb.FallbackController

  def save(conn, params) do
    new_params = params
    |> Map.put("mining_rig_id", conn.assigns.mining_rig.id)

    case AsicRigMonitorRecords.create_asic_rig_monitor_record(new_params) do
      {:ok, asic_rig_monitor_record} ->
        topic_name = "asic_rig_monitor_record:#{conn.assigns.mining_rig.id}"
        Phoenix.PubSub.broadcast(MiningRigMonitor.PubSub, topic_name, {:asic_rig_monitor_record_created,  asic_rig_monitor_record})
        json(conn, :ok)
      {:error, changeset} -> {:error, changeset}
    end
  end
end
