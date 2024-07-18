defmodule MiningRigMonitor.Repo.Migrations.AddAsicModelColumn do
  use Ecto.Migration

  def change do
    alter table(:mining_rigs) do
      add :asic_model, :string
      add :asic_model_variant, :string
    end
  end
end
