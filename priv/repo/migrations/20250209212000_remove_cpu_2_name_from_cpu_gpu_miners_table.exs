defmodule MiningRigMonitor.Repo.Migrations.RemoveCpu2NameFromCpuGpuMinersTable do
  use Ecto.Migration

  def change do
    alter table(:cpu_gpu_miners) do
      remove :cpu_2_name
    end
  end
end
