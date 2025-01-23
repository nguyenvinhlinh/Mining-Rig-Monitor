defmodule MiningRigMonitor.Repo.Migrations.ChangeAsicMinerLogsTabPowerColToInteger do
  use Ecto.Migration

  def change do
    alter table(:asic_miner_logs) do
      modify :power, :integer
    end
  end
end
