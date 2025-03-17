defmodule MiningRigMonitor.Repo.Migrations.CreateAddresses do
  use Ecto.Migration

  def change do
    create table(:addresses) do
      add :name, :string
      add :type, :string
      add :address, :string

      timestamps(type: :utc_datetime)
    end
  end
end
