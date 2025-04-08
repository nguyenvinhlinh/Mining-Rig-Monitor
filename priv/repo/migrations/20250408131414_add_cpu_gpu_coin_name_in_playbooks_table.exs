defmodule MiningRigMonitor.Repo.Migrations.AddCpuGpuCoinNameInPlaybooksTable do
  use Ecto.Migration

  def change do
    alter table(:cpu_gpu_miner_playbooks) do
      add :cpu_coin_name,   :string
      add :gpu_coin_name_1, :string
      add :gpu_coin_name_2, :string

      remove :coin_name_1
      remove :coin_name_2
    end
  end
end
