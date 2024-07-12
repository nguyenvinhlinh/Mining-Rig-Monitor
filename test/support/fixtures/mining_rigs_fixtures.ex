defmodule MiningRigMonitor.MiningRigsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `MiningRigMonitor.MiningRigs` context.
  """

  @doc """
  Generate a mining_rig.
  """
  def mining_rig_fixture(attrs \\ %{}) do
    {:ok, mining_rig} =
      attrs
      |> Enum.into(%{
        code: "some code",
        cpu_1_name: "some cpu_1_name",
        cpu_2_name: "some cpu_2_name",
        name: "some name",
        ram_1_manufacture: "some ram_1_manufacture",
        ram_1_part_number: "some ram_1_part_number",
        ram_1_size: "some ram_1_size",
        ram_1_type: "some ram_1_type",
        ram_2_manufacture: "some ram_2_manufacture",
        ram_2_part_number: "some ram_2_part_number",
        ram_2_size: "some ram_2_size",
        ram_2_type: "some ram_2_type",
        ram_3_manufacture: "some ram_3_manufacture",
        ram_3_part_number: "some ram_3_part_number",
        ram_3_size: "some ram_3_size",
        ram_3_type: "some ram_3_type",
        ram_4_manufacture: "some ram_4_manufacture",
        ram_4_part_number: "some ram_4_part_number",
        ram_4_size: "some ram_4_size",
        ram_4_type: "some ram_4_type",
        vga_1_driver_version: "some vga_1_driver_version",
        vga_1_name: "some vga_1_name",
        vga_1_pci_bus_id: "some vga_1_pci_bus_id",
        vga_1_total_memory: "some vga_1_total_memory",
        vga_1_vbios_version: "some vga_1_vbios_version",
        vga_2_driver_version: "some vga_2_driver_version",
        vga_2_name: "some vga_2_name",
        vga_2_pci_bus_id: "some vga_2_pci_bus_id",
        vga_2_total_memory: "some vga_2_total_memory",
        vga_2_vbios_version: "some vga_2_vbios_version",
        vga_3_driver_version: "some vga_3_driver_version",
        vga_3_name: "some vga_3_name",
        vga_3_pci_bus_id: "some vga_3_pci_bus_id",
        vga_3_total_memory: "some vga_3_total_memory",
        vga_3_vbios_version: "some vga_3_vbios_version",
        vga_4_driver_version: "some vga_4_driver_version",
        vga_4_name: "some vga_4_name",
        vga_4_pci_bus_id: "some vga_4_pci_bus_id",
        vga_4_total_memory: "some vga_4_total_memory",
        vga_4_vbios_version: "some vga_4_vbios_version"
      })
      |> MiningRigMonitor.MiningRigs.create_mining_rig()

    mining_rig
  end
end
