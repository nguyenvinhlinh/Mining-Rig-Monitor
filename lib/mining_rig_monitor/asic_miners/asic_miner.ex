defmodule MiningRigMonitor.AsicMiners.AsicMiner do
  use Ecto.Schema
  import Ecto.Changeset
  alias MiningRigMonitor.AsicMinerLogs.AsicMinerLog
  schema "asic_miners" do
    field :name, :string
    field :api_code, :string
    field :firmware_version, :string
    field :software_version, :string
    field :model, :string
    field :model_variant, :string

    field :activated, :boolean, default: false

    has_many :asic_miner_logs, AsicMinerLog, [on_delete: :delete_all]

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(asic_miner, attrs) do
    asic_miner
    |> cast(attrs, [:name, :api_code, :firmware_version, :software_version, :model, :model_variant])
    |> validate_required([:name, :api_code, :firmware_version, :software_version, :model, :model_variant])
  end

  def changeset_new_by_commander(asic_miner, attrs) do
    asic_miner
    |> cast(attrs, [:name, :api_code])
    |> validate_required([:name, :api_code])
  end

  def changeset_edit_by_commander(asic_miner, attrs) do
    asic_miner
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end

  def changeset_edit_by_sentry(asic_miner, attrs) do
    asic_miner
    |> cast(attrs, [:firmware_version, :software_version, :model, :model_variant, :activated])
    |> validate_required([:activated])
  end
end
