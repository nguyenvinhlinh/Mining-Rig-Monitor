defmodule MiningRigMonitor.CpuGpuMinerLogs.CpuGpuMinerLog do
  use Ecto.Schema
  import Ecto.Changeset

  alias MiningRigMonitor.CpuGpuMiners.CpuGpuMiner
  schema "cpu_gpu_miner_logs" do
    belongs_to :cpu_gpu_miner, CpuGpuMiner, foreign_key: :cpu_gpu_miner_id

    field :cpu_temp, :integer
    field :cpu_hashrate, :integer
    field :cpu_hashrate_uom, :string
    field :cpu_algorithm, :string
    field :cpu_coin_name, :string

    field :gpu_1_core_temp, :integer
    field :gpu_2_core_temp, :integer
    field :gpu_3_core_temp, :integer
    field :gpu_4_core_temp, :integer
    field :gpu_5_core_temp, :integer
    field :gpu_6_core_temp, :integer
    field :gpu_7_core_temp, :integer
    field :gpu_8_core_temp, :integer

    field :gpu_1_mem_temp, :integer
    field :gpu_2_mem_temp, :integer
    field :gpu_3_mem_temp, :integer
    field :gpu_4_mem_temp, :integer
    field :gpu_5_mem_temp, :integer
    field :gpu_6_mem_temp, :integer
    field :gpu_7_mem_temp, :integer
    field :gpu_8_mem_temp, :integer

    field :gpu_1_hashrate_1, :integer
    field :gpu_2_hashrate_1, :integer
    field :gpu_3_hashrate_1, :integer
    field :gpu_4_hashrate_1, :integer
    field :gpu_5_hashrate_1, :integer
    field :gpu_6_hashrate_1, :integer
    field :gpu_7_hashrate_1, :integer
    field :gpu_8_hashrate_1, :integer

    field :gpu_1_hashrate_2, :integer
    field :gpu_2_hashrate_2, :integer
    field :gpu_3_hashrate_2, :integer
    field :gpu_4_hashrate_2, :integer
    field :gpu_5_hashrate_2, :integer
    field :gpu_6_hashrate_2, :integer
    field :gpu_7_hashrate_2, :integer
    field :gpu_8_hashrate_2, :integer

    field :gpu_1_core_clock, :integer
    field :gpu_2_core_clock, :integer
    field :gpu_3_core_clock, :integer
    field :gpu_4_core_clock, :integer
    field :gpu_5_core_clock, :integer
    field :gpu_6_core_clock, :integer
    field :gpu_7_core_clock, :integer
    field :gpu_8_core_clock, :integer

    field :gpu_1_mem_clock, :integer
    field :gpu_2_mem_clock, :integer
    field :gpu_3_mem_clock, :integer
    field :gpu_4_mem_clock, :integer
    field :gpu_5_mem_clock, :integer
    field :gpu_6_mem_clock, :integer
    field :gpu_7_mem_clock, :integer
    field :gpu_8_mem_clock, :integer

    field :gpu_1_power, :integer
    field :gpu_2_power, :integer
    field :gpu_3_power, :integer
    field :gpu_4_power, :integer
    field :gpu_5_power, :integer
    field :gpu_6_power, :integer
    field :gpu_7_power, :integer
    field :gpu_8_power, :integer

    field :gpu_algorithm_1, :string
    field :gpu_algorithm_2, :string

    field :gpu_coin_name_1, :string
    field :gpu_coin_name_2, :string

    field :lan_ip, :string
    field :wan_ip, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(cpu_gpu_miner_log, attrs) do
    cpu_gpu_miner_log
    |> cast(attrs, [])
    |> validate_required([])
  end
end
