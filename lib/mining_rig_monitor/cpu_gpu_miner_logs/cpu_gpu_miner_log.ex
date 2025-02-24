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
    field :cpu_pool_address, :string
    field :cpu_wallet, :string
    field :cpu_power, :integer

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

    field :gpu_1_fan, :integer
    field :gpu_2_fan, :integer
    field :gpu_3_fan, :integer
    field :gpu_4_fan, :integer
    field :gpu_5_fan, :integer
    field :gpu_6_fan, :integer
    field :gpu_7_fan, :integer
    field :gpu_8_fan, :integer

    field :gpu_fan_uom, :string


    field :gpu_algorithm_1, :string
    field :gpu_algorithm_2, :string

    field :gpu_hashrate_uom_1, :string
    field :gpu_hashrate_uom_2, :string

    field :gpu_coin_name_1, :string
    field :gpu_coin_name_2, :string

    field :gpu_pool_address_1, :string
    field :gpu_pool_address_2, :string

    field :gpu_wallet_address_1, :string
    field :gpu_wallet_address_2, :string

    field :lan_ip, :string
    field :wan_ip, :string
    field :uptime, :string


    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(cpu_gpu_miner_log, attrs) do
    field_list =
      [:cpu_temp, :cpu_hashrate, :cpu_hashrate_uom, :cpu_algorithm, :cpu_coin_name,
       :cpu_pool_address, :cpu_wallet, :cpu_power,
       :gpu_1_core_temp, :gpu_2_core_temp, :gpu_3_core_temp, :gpu_4_core_temp,
       :gpu_5_core_temp, :gpu_6_core_temp, :gpu_7_core_temp, :gpu_8_core_temp,

       :gpu_1_mem_temp, :gpu_2_mem_temp, :gpu_3_mem_temp, :gpu_4_mem_temp,
       :gpu_5_mem_temp, :gpu_6_mem_temp, :gpu_7_mem_temp, :gpu_8_mem_temp,

       :gpu_1_hashrate_1, :gpu_2_hashrate_1, :gpu_3_hashrate_1, :gpu_4_hashrate_1,
       :gpu_5_hashrate_1, :gpu_6_hashrate_1, :gpu_7_hashrate_1, :gpu_8_hashrate_1,

       :gpu_1_hashrate_2, :gpu_2_hashrate_2, :gpu_3_hashrate_2, :gpu_4_hashrate_2,
       :gpu_5_hashrate_2, :gpu_6_hashrate_2, :gpu_7_hashrate_2, :gpu_8_hashrate_2,

       :gpu_1_core_clock, :gpu_2_core_clock, :gpu_3_core_clock, :gpu_4_core_clock,
       :gpu_5_core_clock, :gpu_6_core_clock, :gpu_7_core_clock, :gpu_8_core_clock,

       :gpu_1_mem_clock, :gpu_2_mem_clock, :gpu_3_mem_clock, :gpu_4_mem_clock,
       :gpu_5_mem_clock, :gpu_6_mem_clock, :gpu_7_mem_clock, :gpu_8_mem_clock,

       :gpu_1_power, :gpu_2_power, :gpu_3_power, :gpu_4_power,
       :gpu_5_power, :gpu_6_power, :gpu_7_power, :gpu_8_power,

       :gpu_1_fan, :gpu_2_fan, :gpu_3_fan, :gpu_4_fan,
       :gpu_5_fan, :gpu_6_fan, :gpu_7_fan, :gpu_8_fan,

       :gpu_fan_uom,

       :gpu_algorithm_1, :gpu_algorithm_2,
       :gpu_hashrate_uom_1, :gpu_hashrate_uom_2,
       :gpu_coin_name_1, :gpu_coin_name_2,

       :gpu_pool_address_1, :gpu_pool_address_2,
       :gpu_wallet_address_1, :gpu_wallet_address_2,
       :lan_ip, :wan_ip, :uptime,
       :cpu_gpu_miner_id
      ]
    required_field_list = [:cpu_gpu_miner_id]

    cpu_gpu_miner_log
    |> cast(attrs, field_list)
    |> validate_required(required_field_list)
  end


  def sum_gpu_hashrate_1(%__MODULE__{}=cpu_gpu_miner_log) do
    field_list =
      [:gpu_1_hashrate_1, :gpu_2_hashrate_1, :gpu_3_hashrate_1, :gpu_4_hashrate_1,
       :gpu_5_hashrate_1, :gpu_6_hashrate_1, :gpu_7_hashrate_1, :gpu_8_hashrate_1]

    Enum.reduce(field_list, 0, fn(field, acc) ->
      value = Map.get(cpu_gpu_miner_log, field, 0)
      acc + value
    end)
  end

  def sum_gpu_hashrate_2(%__MODULE__{}=cpu_gpu_miner_log) do
    field_list =
      [:gpu_1_hashrate_2, :gpu_2_hashrate_2, :gpu_3_hashrate_2, :gpu_4_hashrate_2,
       :gpu_5_hashrate_2, :gpu_6_hashrate_2, :gpu_7_hashrate_2, :gpu_8_hashrate_2]

    Enum.reduce(field_list, 0, fn(field, acc) ->
      value = Map.get(cpu_gpu_miner_log, field, 0)
      acc + value
    end)
  end

  def find_max_gpu_core_temp(%__MODULE__{}=cpu_gpu_miner_log) do
    field_list =
      [:gpu_1_core_temp, :gpu_2_core_temp, :gpu_3_core_temp, :gpu_4_core_temp,
       :gpu_5_core_temp, :gpu_6_core_temp, :gpu_7_core_temp, :gpu_8_core_temp]

    Enum.reduce(field_list, 0, fn(field, acc) ->
      value = Map.get(cpu_gpu_miner_log, field, 0)
      if value > acc, do: value, else: acc
    end)
  end


  def find_max_gpu_mem_temp(%__MODULE__{}=cpu_gpu_miner_log) do
    field_list =
      [:gpu_1_mem_temp, :gpu_2_mem_temp, :gpu_3_mem_temp, :gpu_4_mem_temp,
       :gpu_5_mem_temp, :gpu_6_mem_temp, :gpu_7_mem_temp, :gpu_8_mem_temp]

    Enum.reduce(field_list, 0, fn(field, acc) ->
      value = Map.get(cpu_gpu_miner_log, field, 0)
      if value > acc, do: value, else: acc
    end)
  end


  def find_max_gpu_fan_speed(%__MODULE__{}=cpu_gpu_miner_log) do
    field_list =
      [:gpu_1_fan, :gpu_2_fan, :gpu_3_fan, :gpu_4_fan,
       :gpu_5_fan, :gpu_6_fan, :gpu_7_fan, :gpu_8_fan]

    Enum.reduce(field_list, 0, fn(field, acc) ->
      value = Map.get(cpu_gpu_miner_log, field, 0)
      if value > acc,  do: value, else: acc
    end)
  end

  def sum_total_power(%__MODULE__{}=cpu_gpu_miner_log) do
    field_list =
      [:cpu_power, :gpu_1_power, :gpu_2_power, :gpu_3_power, :gpu_4_power,
       :gpu_5_power, :gpu_6_power, :gpu_7_power, :gpu_8_power]

    Enum.reduce(field_list, 0, fn(field, acc) ->
      value = Map.get(cpu_gpu_miner_log, field, 0)
      acc + value
    end)
  end
end
