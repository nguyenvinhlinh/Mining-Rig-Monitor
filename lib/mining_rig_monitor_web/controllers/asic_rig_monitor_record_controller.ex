defmodule MiningRigMonitorWeb.AsicRigMonitorRecordController do
  use MiningRigMonitorWeb, :controller

  alias MiningRigMonitor.AsicRigMonitorRecords

  action_fallback MiningRigMonitorWeb.FallbackController

  def save(conn, params) do
    new_params = params
    |> Map.put("mining_rig_id", conn.assigns.mining_rig.id)
    case AsicRigMonitorRecords.create_asic_rig_monitor_record(new_params) do
      {:ok, _record} -> json(conn, :ok)
      {:error, changeset} -> {:error, changeset}
    end
  end
end
