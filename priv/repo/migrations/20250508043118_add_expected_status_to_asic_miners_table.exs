defmodule MiningRigMonitor.Repo.Migrations.AddExpectedStatusToAsicMinersTable do
  use Ecto.Migration

  def change do
    alter table(:asic_miners) do
      add :asic_expected_status,  :string, size: 3, default: "on"
      add :light_expected_status, :string, size: 3, default: "off"
    end
  end
end
