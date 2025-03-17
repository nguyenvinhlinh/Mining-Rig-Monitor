defmodule MiningRigMonitor.Addresses.Address do
  use Ecto.Schema
  import Ecto.Changeset

  schema "addresses" do
    field :name, :string
    field :type, :string
    field :address, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(address, attrs) do
    address
    |> cast(attrs, [:name, :type, :address])
    |> validate_required([:name, :type, :address])
  end
end
