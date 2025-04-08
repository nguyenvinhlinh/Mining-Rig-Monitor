defmodule MiningRigMonitor.Repo.Migrations.AddCpuGpuAlgorithmToPlaybookTable do
  use Ecto.Migration

  def change do
    alter table(:cpu_gpu_miner_playbooks) do
      add :cpu_algorithm,   :string
      add :gpu_algorithm_1, :string
      add :gpu_algorithm_2, :string

      remove :algorithm_1
      remove :algorithm_2
    end
  end
end
