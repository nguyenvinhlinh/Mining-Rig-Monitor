defmodule MiningRigMonitor.Repo.Migrations.CreateAsicMiners do
  use Ecto.Migration

  def change do
    create table(:asic_miners) do
      add :name, :string
      add :api_code, :string
      add :firmware_version, :string
      add :software_version, :string
      add :model, :string
      add :model_variant, :string

      timestamps(type: :utc_datetime)
    end
  end
end
