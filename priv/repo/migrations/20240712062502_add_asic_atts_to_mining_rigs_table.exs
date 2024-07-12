defmodule MiningRigMonitor.Repo.Migrations.AddAsicAttsToMiningRigsTable do
  use Ecto.Migration

  def change do
    alter table(:mining_rigs) do
      add :type, :string
      add :asic_firmware_version, :string
      add :asic_software_version, :string
    end
  end
end
