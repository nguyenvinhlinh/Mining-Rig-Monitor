defmodule MiningRigMonitor.CpuGpuMiners.CpuGpuMiner do
  use Ecto.Schema
  import Ecto.Changeset

  schema "cpu_gpu_miners" do
    field :name, :string
    field :api_code, :string

    field :cpu_1_name, :string
    field :cpu_2_name, :string

    field :ram_size, :string

    field :gpu_1_name, :string
    field :gpu_2_name, :string
    field :gpu_3_name, :string
    field :gpu_4_name, :string
    field :gpu_5_name, :string
    field :gpu_6_name, :string
    field :gpu_7_name, :string
    field :gpu_8_name, :string

    field :activated, :boolean, default: false

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(cpu_gpu_miner, attrs) do
    cpu_gpu_miner
    |> cast(attrs, [:name, :api_code, :cpu_1_name, :cpu_2_name, :ram_size, :gpu_1_name, :gpu_2_name, :gpu_3_name, :gpu_4_name, :gpu_5_name, :gpu_6_name, :gpu_7_name, :gpu_8_name])
    |> validate_required([:name, :api_code, :cpu_1_name, :cpu_2_name, :ram_size, :gpu_1_name, :gpu_2_name, :gpu_3_name, :gpu_4_name, :gpu_5_name, :gpu_6_name, :gpu_7_name, :gpu_8_name])
  end

  def changeset_new_by_commander(cpu_gpu_miner, attrs) do
    cpu_gpu_miner
    |> cast(attrs, [:name, :api_code])
    |> validate_required([:name, :api_code])
  end
end
