defmodule MiningRigMonitor.Repo.Migrations.CreateCpuGpuMinerPlaybooks do
  use Ecto.Migration

  def change do
    create table(:cpu_gpu_miner_playbooks) do
      add :cpu_gpu_miner_id, references("cpu_gpu_miners")
      add :software_name, :string
      add :software_version, :string
      add :command_argument, :string

      timestamps(type: :utc_datetime)
    end
  end
end
