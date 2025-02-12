defmodule MiningRigMonitor.Repo.Migrations.RenameCpu1NameToCpuNameCpuGpuMinersTable do
  use Ecto.Migration

  def change do
    rename table(:cpu_gpu_miners), :cpu_1_name, to: :cpu_name
  end
end
