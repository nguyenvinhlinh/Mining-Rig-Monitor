defmodule MiningRigMonitor.Repo.Migrations.ChangeTableAsicRigMonitorRecordColUpdateToString do
  use Ecto.Migration

  def change do
    alter table(:asic_rig_monitor_records) do
      remove :uptime
    end

    alter table(:asic_rig_monitor_records) do
      # Uptime, in ASIC KS5L, check JSON key named runtime in format: days:hours:minutes:seconds
      # example: "00:00:39:34".
      # When submit to the Mining Rig Monitor Server, keep this format.
      add :uptime, :string, size: 11
    end
  end
end
