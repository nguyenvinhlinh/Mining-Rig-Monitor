defmodule MiningRigMonitor.Repo.Migrations.ChangeAsicMinerLogsTabTempColToInteger do
  use Ecto.Migration

  def change do
    alter table(:asic_miner_logs) do
      modify :hashboard_1_temp_1, :integer
      modify :hashboard_1_temp_2, :integer

      modify :hashboard_2_temp_1, :integer
      modify :hashboard_2_temp_2, :integer

      modify :hashboard_3_temp_1, :integer
      modify :hashboard_3_temp_2, :integer
    end
  end
end
