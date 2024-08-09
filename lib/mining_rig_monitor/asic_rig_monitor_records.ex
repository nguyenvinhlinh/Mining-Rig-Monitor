defmodule MiningRigMonitor.AsicRigMonitorRecords do
  import Ecto.Query
  alias MiningRigMonitor.AsicRigMonitorRecords.AsicRigMonitorRecord
  alias MiningRigMonitor.Repo


  def create_asic_rig_monitor_record(attrs \\ %{}) do
    %AsicRigMonitorRecord{}
    |> AsicRigMonitorRecord.changeset(attrs)
    |> Repo.insert()
  end

  def get_latest_asic_monitor_record(mining_rig_asic_id) do
    AsicRigMonitorRecord
    |> where([r], r.mining_rig_id == ^mining_rig_asic_id)
    |> order_by([r], desc: r.id)
    |> limit(1)
    |> Repo.one
  end
end
