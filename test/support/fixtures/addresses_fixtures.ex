defmodule MiningRigMonitor.AddressesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `MiningRigMonitor.Addresses` context.
  """

  @doc """
  Generate a address.
  """
  def address_fixture(attrs \\ %{}) do
    {:ok, address} =
      attrs
      |> Enum.into(%{
        address: "some address",
        name: "some name",
        type: "some type"
      })
      |> MiningRigMonitor.Addresses.create_address()

    address
  end
end
