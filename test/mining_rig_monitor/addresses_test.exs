defmodule MiningRigMonitor.AddressesTest do
  use MiningRigMonitor.DataCase

  alias MiningRigMonitor.Addresses

  describe "addresses" do
    alias MiningRigMonitor.Addresses.Address

    import MiningRigMonitor.AddressesFixtures

    @invalid_attrs %{name: nil, type: nil, address: nil}

    test "list_addresses/0 returns all addresses" do
      address = address_fixture()
      assert Addresses.list_addresses() == [address]
    end

    test "get_address!/1 returns the address with given id" do
      address = address_fixture()
      assert Addresses.get_address!(address.id) == address
    end

    test "create_address/1 with valid data creates a address" do
      valid_attrs = %{name: "some name", type: "some type", address: "some address"}

      assert {:ok, %Address{} = address} = Addresses.create_address(valid_attrs)
      assert address.name == "some name"
      assert address.type == "some type"
      assert address.address == "some address"
    end

    test "create_address/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Addresses.create_address(@invalid_attrs)
    end

    test "update_address/2 with valid data updates the address" do
      address = address_fixture()
      update_attrs = %{name: "some updated name", address: "some updated address"}

      assert {:ok, %Address{} = address} = Addresses.update_address(address, update_attrs)
      assert address.name == "some updated name"
      assert address.address == "some updated address"
    end

    test "update_address/2 with invalid data returns error changeset" do
      address = address_fixture()
      assert {:error, %Ecto.Changeset{}} = Addresses.update_address(address, @invalid_attrs)
      assert address == Addresses.get_address!(address.id)
    end

    test "delete_address/1 deletes the address" do
      address = address_fixture()
      assert {:ok, %Address{}} = Addresses.delete_address(address)
      assert_raise Ecto.NoResultsError, fn -> Addresses.get_address!(address.id) end
    end

    test "change_address/1 returns a address changeset" do
      address = address_fixture()
      assert %Ecto.Changeset{} = Addresses.change_address(address)
    end
  end
end
