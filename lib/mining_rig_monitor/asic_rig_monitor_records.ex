defmodule MiningRigMonitor.AsicRigMonitorRecords do
  alias MiningRigMonitor.AsicRigMonitorRecords.AsicRigMonitorRecord
  alias MiningRigMonitor.Repo

  def create_asic_rig_monitor_record(attrs \\ %{}) do
    %AsicRigMonitorRecord{}
    |> AsicRigMonitorRecord.changeset(attrs)
    |> Repo.insert()
  end
end
