defmodule MiningRigMonitor.Repo.Migrations.RemoveMiningRigsTable do
  use Ecto.Migration

  def change do
    drop table("mining_rigs")
  end
end
