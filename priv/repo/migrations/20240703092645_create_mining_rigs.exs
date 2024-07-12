defmodule MiningRigMonitor.Repo.Migrations.CreateMiningRigs do
  use Ecto.Migration

  def change do
    create table(:mining_rigs) do
      add :name, :string
      add :code, :string
      add :cpu_1_name, :string
      add :cpu_2_name, :string
      add :ram_1_size, :string
      add :ram_2_size, :string
      add :ram_3_size, :string
      add :ram_4_size, :string
      add :ram_1_type, :string
      add :ram_2_type, :string
      add :ram_3_type, :string
      add :ram_4_type, :string
      add :ram_1_manufacture, :string
      add :ram_2_manufacture, :string
      add :ram_3_manufacture, :string
      add :ram_4_manufacture, :string
      add :ram_1_part_number, :string
      add :ram_2_part_number, :string
      add :ram_3_part_number, :string
      add :ram_4_part_number, :string
      add :vga_1_name, :string
      add :vga_2_name, :string
      add :vga_3_name, :string
      add :vga_4_name, :string
      add :vga_1_driver_version, :string
      add :vga_2_driver_version, :string
      add :vga_3_driver_version, :string
      add :vga_4_driver_version, :string
      add :vga_1_vbios_version, :string
      add :vga_2_vbios_version, :string
      add :vga_3_vbios_version, :string
      add :vga_4_vbios_version, :string
      add :vga_1_total_memory, :string
      add :vga_2_total_memory, :string
      add :vga_3_total_memory, :string
      add :vga_4_total_memory, :string
      add :vga_1_pci_bus_id, :string
      add :vga_2_pci_bus_id, :string
      add :vga_3_pci_bus_id, :string
      add :vga_4_pci_bus_id, :string

      timestamps(type: :utc_datetime)
    end
  end
end
