defmodule MiningRigMonitor.Repo.Migrations.AddCoinNameToPlaybookTable do
  use Ecto.Migration

  def change do
    alter table(:cpu_gpu_miner_playbooks) do
      add :coin_name_1, :string
      add :coin_name_2, :string
      add :algorithm_1, :string
      add :algorithm_2, :string
    end
  end
end
