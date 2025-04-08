defmodule MiningRigMonitor.Repo.Migrations.AddCoinNamePoolAddressToCpuGpuMinerPlaybooksTable do
  use Ecto.Migration

  def change do
    alter table(:cpu_gpu_miner_playbooks) do
      add :cpu_wallet_address_id,   references("addresses", on_delete: :nilify_all)
      add :gpu_wallet_address_1_id, references("addresses", on_delete: :nilify_all)
      add :gpu_wallet_address_2_id, references("addresses", on_delete: :nilify_all)

      add :cpu_pool_address_id,   references("addresses", on_delete: :nilify_all)
      add :gpu_pool_address_1_id, references("addresses", on_delete: :nilify_all)
      add :gpu_pool_address_2_id, references("addresses", on_delete: :nilify_all)
    end
  end
end
