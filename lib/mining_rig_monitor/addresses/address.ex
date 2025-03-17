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
  def type_pool(), do: @type_pool

  @doc false
  def changeset(address, attrs) do
    address
    |> cast(attrs, [:name, :type, :address])
    |> validate_required([:name, :type, :address])
  end
end
