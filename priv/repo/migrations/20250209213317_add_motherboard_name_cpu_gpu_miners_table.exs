defmodule MiningRigMonitor.Repo.Migrations.AddMotherboardNameCpuGpuMinersTable do
  use Ecto.Migration

  def change do
    alter table(:cpu_gpu_miners) do
      add :motherboard_name, :string
    end
  end
end
