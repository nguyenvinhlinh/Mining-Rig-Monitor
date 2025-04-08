defmodule MiningRigMonitor.Repo.Migrations.ChangeCpuWalletToCpuWalletAddressInCpuGpuMinerLogTable do
  use Ecto.Migration

  def change do
    rename table(:cpu_gpu_miner_logs), :cpu_wallet, to: :cpu_wallet_address
  end
end
