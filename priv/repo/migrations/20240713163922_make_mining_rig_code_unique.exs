defmodule MiningRigMonitor.Repo.Migrations.MakeMiningRigCodeUnique do
  use Ecto.Migration

  def change do
    create unique_index(:mining_rigs, [:code])
  end
end
