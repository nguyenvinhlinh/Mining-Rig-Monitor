defmodule MiningRigMonitor.Addresses.Address do
  use Ecto.Schema
  import Ecto.Changeset

  @type_wallet "wallet"
  @type_pool "pool"

  schema "addresses" do
    field :name, :string
    field :type, :string
    field :address, :string
    timestamps(type: :utc_datetime)
  end

  def type_wallet(), do: @type_wallet
  def type_pool(),   do: @type_pool

  @doc false
  def changeset(address, attrs) do
    address
    |> cast(attrs, [:name, :type, :address])
    |> validate_required([:name, :type, :address])
  end

  def changeset_new(address, attrs) do
    address
    |> cast(attrs, [:name, :type, :address])
    |> validate_required([:name, :type, :address])
    |> validate_length(:name, [min: 2])
    |> validate_length(:address, [min: 2])
  end

  def changeset_update(address, attrs) do
    address
    |> cast(attrs, [:name, :address])
    |> validate_required([:name, :address])
    |> validate_length(:name, [min: 2])
    |> validate_length(:address, [min: 2])
  end
end
