defmodule MiningRigMonitor.Repo.Migrations.AddGpuFanUomToCpuGpuMinerLogsTable do
  use Ecto.Migration

  def change do
    alter table(:cpu_gpu_miner_logs) do
      add :gpu_fan_uom, :string

      remove :gpu_1_fan
      remove :gpu_2_fan
      remove :gpu_3_fan
      remove :gpu_4_fan

      remove :gpu_5_fan
      remove :gpu_6_fan
      remove :gpu_7_fan
      remove :gpu_8_fan

      add :gpu_1_fan, :integer
      add :gpu_2_fan, :integer
      add :gpu_3_fan, :integer
      add :gpu_4_fan, :integer

      add :gpu_5_fan, :integer
      add :gpu_6_fan, :integer
      add :gpu_7_fan, :integer
      add :gpu_8_fan, :integer
    end
  end
end
