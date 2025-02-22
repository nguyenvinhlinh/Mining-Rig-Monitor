defmodule MiningRigMonitor.Repo.Migrations.AddGpuFanSpeedUptimeToCpuGpuMinerLogTable do
  use Ecto.Migration

  def change do
    alter table(:cpu_gpu_miner_logs) do
      add :gpu_1_fan, :string
      add :gpu_2_fan, :string
      add :gpu_3_fan, :string
      add :gpu_4_fan, :string

      add :gpu_5_fan, :string
      add :gpu_6_fan, :string
      add :gpu_7_fan, :string
      add :gpu_8_fan, :string

      add :uptime, :string
    end
  end
end
