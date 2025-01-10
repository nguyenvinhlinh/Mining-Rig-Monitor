defmodule MiningRigMonitor.AsicMiners.AsicMiner do
  use Ecto.Schema
  import Ecto.Changeset

  schema "asic_miners" do
    field :name, :string
    field :api_code, :string
    field :firmware_version, :string
    field :software_version, :string
    field :model, :string
    field :model_variant, :string

    field :activated, :boolean

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(asic_miner, attrs) do
    asic_miner
    |> cast(attrs, [:name, :api_code, :firmware_version, :software_version, :model, :model_variant])
    |> validate_required([:name, :api_code, :firmware_version, :software_version, :model, :model_variant])
  end

  def changeset_new(asic_miner, attrs) do
    asic_miner
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
