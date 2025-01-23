defmodule MiningRigMonitor.Repo.Migrations.RemoveAsicRigMonitorRecordsTable do
  use Ecto.Migration

  def change do
    drop table("asic_rig_monitor_records")
  end
end
