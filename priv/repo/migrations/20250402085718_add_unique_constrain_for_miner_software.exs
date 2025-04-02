defmodule MiningRigMonitor.Repo.Migrations.AddUniqueConstrainForMinerSoftware do
  use Ecto.Migration

  def change do
    create unique_index("cpu_gpu_miner_playbooks", [:cpu_gpu_miner_id, :software_name])
  end
end
