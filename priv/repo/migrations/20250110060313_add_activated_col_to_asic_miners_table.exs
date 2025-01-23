defmodule MiningRigMonitor.Repo.Migrations.AddActivatedColToAsicMinersTable do
  use Ecto.Migration

  def change do
    alter table(:asic_miners) do
      add :activated, :boolean, default: false
    end
  end
end
