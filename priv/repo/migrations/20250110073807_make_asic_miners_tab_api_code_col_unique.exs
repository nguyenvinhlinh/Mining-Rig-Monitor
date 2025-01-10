defmodule MiningRigMonitor.Repo.Migrations.MakeAsicMinersTabApiCodeColUnique do
  use Ecto.Migration

  def up do
    create unique_index(:asic_miners, [:api_code], [unique: true])
  end

  def down do
    drop unique_index(:asic_miners, [:api_code])
  end
end
