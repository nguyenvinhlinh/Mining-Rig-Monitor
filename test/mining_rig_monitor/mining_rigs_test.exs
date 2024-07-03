defmodule MiningRigMonitor.MiningRigsTest do
  use MiningRigMonitor.DataCase

  alias MiningRigMonitor.MiningRigs

  describe "mining_rigs" do
    alias MiningRigMonitor.MiningRigs.MiningRig

    import MiningRigMonitor.MiningRigsFixtures

    @invalid_attrs %{vga_1_pci_bus_id: nil, ram_1_manufacture: nil, ram_4_size: nil, code: nil, vga_1_name: nil, ram_3_part_number: nil, vga_1_vbios_version: nil, ram_4_part_number: nil, vga_2_pci_bus_id: nil, ram_3_type: nil, vga_4_name: nil, vga_1_driver_version: nil, ram_1_type: nil, ram_2_part_number: nil, ram_3_manufacture: nil, vga_2_vbios_version: nil, ram_2_type: nil, vga_3_vbios_version: nil, vga_3_name: nil, ram_3_size: nil, cpu_1_name: nil, ram_1_size: nil, vga_3_driver_version: nil, ram_2_size: nil, vga_4_pci_bus_id: nil, vga_1_total_memory: nil, vga_3_total_memory: nil, ram_1_part_number: nil, ram_2_manufacture: nil, name: nil, vga_2_total_memory: nil, ram_4_manufacture: nil, vga_4_vbios_version: nil, vga_3_pci_bus_id: nil, vga_4_driver_version: nil, ram_4_type: nil, cpu_2_name: nil, vga_2_name: nil, vga_2_driver_version: nil, vga_4_total_memory: nil}

    test "list_mining_rigs/0 returns all mining_rigs" do
      mining_rig = mining_rig_fixture()
      assert MiningRigs.list_mining_rigs() == [mining_rig]
    end

    test "get_mining_rig!/1 returns the mining_rig with given id" do
      mining_rig = mining_rig_fixture()
      assert MiningRigs.get_mining_rig!(mining_rig.id) == mining_rig
    end

    test "create_mining_rig/1 with valid data creates a mining_rig" do
      valid_attrs = %{vga_1_pci_bus_id: "some vga_1_pci_bus_id", ram_1_manufacture: "some ram_1_manufacture", ram_4_size: "some ram_4_size", code: "some code", vga_1_name: "some vga_1_name", ram_3_part_number: "some ram_3_part_number", vga_1_vbios_version: "some vga_1_vbios_version", ram_4_part_number: "some ram_4_part_number", vga_2_pci_bus_id: "some vga_2_pci_bus_id", ram_3_type: "some ram_3_type", vga_4_name: "some vga_4_name", vga_1_driver_version: "some vga_1_driver_version", ram_1_type: "some ram_1_type", ram_2_part_number: "some ram_2_part_number", ram_3_manufacture: "some ram_3_manufacture", vga_2_vbios_version: "some vga_2_vbios_version", ram_2_type: "some ram_2_type", vga_3_vbios_version: "some vga_3_vbios_version", vga_3_name: "some vga_3_name", ram_3_size: "some ram_3_size", cpu_1_name: "some cpu_1_name", ram_1_size: "some ram_1_size", vga_3_driver_version: "some vga_3_driver_version", ram_2_size: "some ram_2_size", vga_4_pci_bus_id: "some vga_4_pci_bus_id", vga_1_total_memory: "some vga_1_total_memory", vga_3_total_memory: "some vga_3_total_memory", ram_1_part_number: "some ram_1_part_number", ram_2_manufacture: "some ram_2_manufacture", name: "some name", vga_2_total_memory: "some vga_2_total_memory", ram_4_manufacture: "some ram_4_manufacture", vga_4_vbios_version: "some vga_4_vbios_version", vga_3_pci_bus_id: "some vga_3_pci_bus_id", vga_4_driver_version: "some vga_4_driver_version", ram_4_type: "some ram_4_type", cpu_2_name: "some cpu_2_name", vga_2_name: "some vga_2_name", vga_2_driver_version: "some vga_2_driver_version", vga_4_total_memory: "some vga_4_total_memory"}

      assert {:ok, %MiningRig{} = mining_rig} = MiningRigs.create_mining_rig(valid_attrs)
      assert mining_rig.vga_4_total_memory == "some vga_4_total_memory"
      assert mining_rig.vga_2_driver_version == "some vga_2_driver_version"
      assert mining_rig.vga_2_name == "some vga_2_name"
      assert mining_rig.cpu_2_name == "some cpu_2_name"
      assert mining_rig.ram_4_type == "some ram_4_type"
      assert mining_rig.vga_4_driver_version == "some vga_4_driver_version"
      assert mining_rig.vga_3_pci_bus_id == "some vga_3_pci_bus_id"
      assert mining_rig.vga_4_vbios_version == "some vga_4_vbios_version"
      assert mining_rig.ram_4_manufacture == "some ram_4_manufacture"
      assert mining_rig.vga_2_total_memory == "some vga_2_total_memory"
      assert mining_rig.name == "some name"
      assert mining_rig.ram_2_manufacture == "some ram_2_manufacture"
      assert mining_rig.ram_1_part_number == "some ram_1_part_number"
      assert mining_rig.vga_3_total_memory == "some vga_3_total_memory"
      assert mining_rig.vga_1_total_memory == "some vga_1_total_memory"
      assert mining_rig.vga_4_pci_bus_id == "some vga_4_pci_bus_id"
      assert mining_rig.ram_2_size == "some ram_2_size"
      assert mining_rig.vga_3_driver_version == "some vga_3_driver_version"
      assert mining_rig.ram_1_size == "some ram_1_size"
      assert mining_rig.cpu_1_name == "some cpu_1_name"
      assert mining_rig.ram_3_size == "some ram_3_size"
      assert mining_rig.vga_3_name == "some vga_3_name"
      assert mining_rig.vga_3_vbios_version == "some vga_3_vbios_version"
      assert mining_rig.ram_2_type == "some ram_2_type"
      assert mining_rig.vga_2_vbios_version == "some vga_2_vbios_version"
      assert mining_rig.ram_3_manufacture == "some ram_3_manufacture"
      assert mining_rig.ram_2_part_number == "some ram_2_part_number"
      assert mining_rig.ram_1_type == "some ram_1_type"
      assert mining_rig.vga_1_driver_version == "some vga_1_driver_version"
      assert mining_rig.vga_4_name == "some vga_4_name"
      assert mining_rig.ram_3_type == "some ram_3_type"
      assert mining_rig.vga_2_pci_bus_id == "some vga_2_pci_bus_id"
      assert mining_rig.ram_4_part_number == "some ram_4_part_number"
      assert mining_rig.vga_1_vbios_version == "some vga_1_vbios_version"
      assert mining_rig.ram_3_part_number == "some ram_3_part_number"
      assert mining_rig.vga_1_name == "some vga_1_name"
      assert mining_rig.code == "some code"
      assert mining_rig.ram_4_size == "some ram_4_size"
      assert mining_rig.ram_1_manufacture == "some ram_1_manufacture"
      assert mining_rig.vga_1_pci_bus_id == "some vga_1_pci_bus_id"
    end

    test "create_mining_rig/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = MiningRigs.create_mining_rig(@invalid_attrs)
    end

    test "update_mining_rig/2 with valid data updates the mining_rig" do
      mining_rig = mining_rig_fixture()
      update_attrs = %{vga_1_pci_bus_id: "some updated vga_1_pci_bus_id", ram_1_manufacture: "some updated ram_1_manufacture", ram_4_size: "some updated ram_4_size", code: "some updated code", vga_1_name: "some updated vga_1_name", ram_3_part_number: "some updated ram_3_part_number", vga_1_vbios_version: "some updated vga_1_vbios_version", ram_4_part_number: "some updated ram_4_part_number", vga_2_pci_bus_id: "some updated vga_2_pci_bus_id", ram_3_type: "some updated ram_3_type", vga_4_name: "some updated vga_4_name", vga_1_driver_version: "some updated vga_1_driver_version", ram_1_type: "some updated ram_1_type", ram_2_part_number: "some updated ram_2_part_number", ram_3_manufacture: "some updated ram_3_manufacture", vga_2_vbios_version: "some updated vga_2_vbios_version", ram_2_type: "some updated ram_2_type", vga_3_vbios_version: "some updated vga_3_vbios_version", vga_3_name: "some updated vga_3_name", ram_3_size: "some updated ram_3_size", cpu_1_name: "some updated cpu_1_name", ram_1_size: "some updated ram_1_size", vga_3_driver_version: "some updated vga_3_driver_version", ram_2_size: "some updated ram_2_size", vga_4_pci_bus_id: "some updated vga_4_pci_bus_id", vga_1_total_memory: "some updated vga_1_total_memory", vga_3_total_memory: "some updated vga_3_total_memory", ram_1_part_number: "some updated ram_1_part_number", ram_2_manufacture: "some updated ram_2_manufacture", name: "some updated name", vga_2_total_memory: "some updated vga_2_total_memory", ram_4_manufacture: "some updated ram_4_manufacture", vga_4_vbios_version: "some updated vga_4_vbios_version", vga_3_pci_bus_id: "some updated vga_3_pci_bus_id", vga_4_driver_version: "some updated vga_4_driver_version", ram_4_type: "some updated ram_4_type", cpu_2_name: "some updated cpu_2_name", vga_2_name: "some updated vga_2_name", vga_2_driver_version: "some updated vga_2_driver_version", vga_4_total_memory: "some updated vga_4_total_memory"}

      assert {:ok, %MiningRig{} = mining_rig} = MiningRigs.update_mining_rig(mining_rig, update_attrs)
      assert mining_rig.vga_4_total_memory == "some updated vga_4_total_memory"
      assert mining_rig.vga_2_driver_version == "some updated vga_2_driver_version"
      assert mining_rig.vga_2_name == "some updated vga_2_name"
      assert mining_rig.cpu_2_name == "some updated cpu_2_name"
      assert mining_rig.ram_4_type == "some updated ram_4_type"
      assert mining_rig.vga_4_driver_version == "some updated vga_4_driver_version"
      assert mining_rig.vga_3_pci_bus_id == "some updated vga_3_pci_bus_id"
      assert mining_rig.vga_4_vbios_version == "some updated vga_4_vbios_version"
      assert mining_rig.ram_4_manufacture == "some updated ram_4_manufacture"
      assert mining_rig.vga_2_total_memory == "some updated vga_2_total_memory"
      assert mining_rig.name == "some updated name"
      assert mining_rig.ram_2_manufacture == "some updated ram_2_manufacture"
      assert mining_rig.ram_1_part_number == "some updated ram_1_part_number"
      assert mining_rig.vga_3_total_memory == "some updated vga_3_total_memory"
      assert mining_rig.vga_1_total_memory == "some updated vga_1_total_memory"
      assert mining_rig.vga_4_pci_bus_id == "some updated vga_4_pci_bus_id"
      assert mining_rig.ram_2_size == "some updated ram_2_size"
      assert mining_rig.vga_3_driver_version == "some updated vga_3_driver_version"
      assert mining_rig.ram_1_size == "some updated ram_1_size"
      assert mining_rig.cpu_1_name == "some updated cpu_1_name"
      assert mining_rig.ram_3_size == "some updated ram_3_size"
      assert mining_rig.vga_3_name == "some updated vga_3_name"
      assert mining_rig.vga_3_vbios_version == "some updated vga_3_vbios_version"
      assert mining_rig.ram_2_type == "some updated ram_2_type"
      assert mining_rig.vga_2_vbios_version == "some updated vga_2_vbios_version"
      assert mining_rig.ram_3_manufacture == "some updated ram_3_manufacture"
      assert mining_rig.ram_2_part_number == "some updated ram_2_part_number"
      assert mining_rig.ram_1_type == "some updated ram_1_type"
      assert mining_rig.vga_1_driver_version == "some updated vga_1_driver_version"
      assert mining_rig.vga_4_name == "some updated vga_4_name"
      assert mining_rig.ram_3_type == "some updated ram_3_type"
      assert mining_rig.vga_2_pci_bus_id == "some updated vga_2_pci_bus_id"
      assert mining_rig.ram_4_part_number == "some updated ram_4_part_number"
      assert mining_rig.vga_1_vbios_version == "some updated vga_1_vbios_version"
      assert mining_rig.ram_3_part_number == "some updated ram_3_part_number"
      assert mining_rig.vga_1_name == "some updated vga_1_name"
      assert mining_rig.code == "some updated code"
      assert mining_rig.ram_4_size == "some updated ram_4_size"
      assert mining_rig.ram_1_manufacture == "some updated ram_1_manufacture"
      assert mining_rig.vga_1_pci_bus_id == "some updated vga_1_pci_bus_id"
    end

    test "update_mining_rig/2 with invalid data returns error changeset" do
      mining_rig = mining_rig_fixture()
      assert {:error, %Ecto.Changeset{}} = MiningRigs.update_mining_rig(mining_rig, @invalid_attrs)
      assert mining_rig == MiningRigs.get_mining_rig!(mining_rig.id)
    end

    test "delete_mining_rig/1 deletes the mining_rig" do
      mining_rig = mining_rig_fixture()
      assert {:ok, %MiningRig{}} = MiningRigs.delete_mining_rig(mining_rig)
      assert_raise Ecto.NoResultsError, fn -> MiningRigs.get_mining_rig!(mining_rig.id) end
    end

    test "change_mining_rig/1 returns a mining_rig changeset" do
      mining_rig = mining_rig_fixture()
      assert %Ecto.Changeset{} = MiningRigs.change_mining_rig(mining_rig)
    end
  end
end
