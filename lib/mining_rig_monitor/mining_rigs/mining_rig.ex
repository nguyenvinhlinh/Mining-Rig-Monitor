defmodule MiningRigMonitor.MiningRigs.MiningRig do
  use Ecto.Schema
  import Ecto.Changeset

  schema "mining_rigs" do
    field :name, :string
    field :code, :string
    field :type, :string

    field :vga_4_total_memory, :string
    field :vga_2_driver_version, :string
    field :vga_2_name, :string
    field :cpu_2_name, :string
    field :ram_4_type, :string
    field :vga_4_driver_version, :string
    field :vga_3_pci_bus_id, :string
    field :vga_4_vbios_version, :string
    field :ram_4_manufacture, :string
    field :vga_2_total_memory, :string

    field :ram_2_manufacture, :string
    field :ram_1_part_number, :string
    field :vga_3_total_memory, :string
    field :vga_1_total_memory, :string
    field :vga_4_pci_bus_id, :string
    field :ram_2_size, :string
    field :vga_3_driver_version, :string
    field :ram_1_size, :string
    field :cpu_1_name, :string
    field :ram_3_size, :string
    field :vga_3_name, :string
    field :vga_3_vbios_version, :string
    field :ram_2_type, :string
    field :vga_2_vbios_version, :string
    field :ram_3_manufacture, :string
    field :ram_2_part_number, :string
    field :ram_1_type, :string
    field :vga_1_driver_version, :string
    field :vga_4_name, :string
    field :ram_3_type, :string
    field :vga_2_pci_bus_id, :string
    field :ram_4_part_number, :string
    field :vga_1_vbios_version, :string
    field :ram_3_part_number, :string
    field :vga_1_name, :string

    field :ram_4_size, :string
    field :ram_1_manufacture, :string
    field :vga_1_pci_bus_id, :string

    field :asic_model, :string
    field :asic_model_variant, :string
    field :asic_firmware_version, :string
    field :asic_software_version, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(mining_rig, attrs) do
    mining_rig
    |> cast(attrs, [:name, :code, :type, :cpu_1_name, :cpu_2_name, :ram_1_size, :ram_2_size, :ram_3_size, :ram_4_size, :ram_1_type, :ram_2_type, :ram_3_type, :ram_4_type, :ram_1_manufacture, :ram_2_manufacture, :ram_3_manufacture, :ram_4_manufacture, :ram_1_part_number, :ram_2_part_number, :ram_3_part_number, :ram_4_part_number, :vga_1_name, :vga_2_name, :vga_3_name, :vga_4_name, :vga_1_driver_version, :vga_2_driver_version, :vga_3_driver_version, :vga_4_driver_version, :vga_1_vbios_version, :vga_2_vbios_version, :vga_3_vbios_version, :vga_4_vbios_version, :vga_1_total_memory, :vga_2_total_memory, :vga_3_total_memory, :vga_4_total_memory, :vga_1_pci_bus_id, :vga_2_pci_bus_id, :vga_3_pci_bus_id, :vga_4_pci_bus_id])
    |> validate_required([:name, :code])
  end

  def type_cpu_gpu(), do: "cpu_gpu"
  def type_asic(), do: "asic"
  def type_nil(), do: nil


  def changeset_asic(mining_rig, attrs) do
    new_attrs = Map.put(attrs, "type", type_asic())

    mining_rig
    |> cast(new_attrs, [:type, :asic_model, :asic_model_variant, :asic_firmware_version, :asic_software_version])
    |> validate_required([:type])
  end

end
