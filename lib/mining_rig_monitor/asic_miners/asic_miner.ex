defmodule MiningRigMonitor.AsicMiners.AsicMiner do
  use Ecto.Schema
  import Ecto.Changeset
  alias MiningRigMonitor.AsicMinerLogs.AsicMinerLog

  @asic_expected_status_on "on"
  @asic_expected_status_off "off"
  @light_expected_status_on "on"
  @light_expected_status_off "off"
  schema "asic_miners" do
    field :name, :string
    field :api_code, :string
    field :firmware_version, :string
    field :software_version, :string
    field :model, :string
    field :model_variant, :string

    field :activated, :boolean, default: false

    field :asic_expected_status,  :string
    field :light_expected_status, :string

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
    |> cast(attrs, [:name, :api_code, :asic_expected_status, :light_expected_status])
    |> validate_required([:name, :api_code, :asic_expected_status, :light_expected_status])
    |> validate_length(:name, [min: 2])
    |> unique_constraint([:api_code])
  end

  def changeset_edit_by_commander(asic_miner, attrs) do
    asic_miner
    |> cast(attrs, [:name, :asic_expected_status, :light_expected_status])
    |> validate_required([:name, :asic_expected_status, :light_expected_status])
    |> validate_inclusion(:asic_expected_status,  [@asic_expected_status_on,  @asic_expected_status_off])
    |> validate_inclusion(:light_expected_status, [@light_expected_status_on, @light_expected_status_off])
  end

  def changeset_edit_by_sentry(asic_miner, attrs) do
    asic_miner
    |> cast(attrs,       [:model, :model_variant, :firmware_version, :software_version, :activated])
    |> validate_required([:model,                 :firmware_version, :software_version, :activated])
  end

  def asic_expected_status_on,   do: @asic_expected_status_on
  def asic_expected_status_off,  do: @asic_expected_status_off
  def light_expected_status_on,  do: @light_expected_status_on
  def light_expected_status_off, do: @light_expected_status_off
end
