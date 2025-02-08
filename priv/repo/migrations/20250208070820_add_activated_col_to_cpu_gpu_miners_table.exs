defmodule MiningRigMonitor.Repo.Migrations.AddActivatedColToCpuGpuMinersTable do
  use Ecto.Migration

  def change do
    alter table(:cpu_gpu_miners) do
      add :activated, :boolean, default: false
    end
  end
end
