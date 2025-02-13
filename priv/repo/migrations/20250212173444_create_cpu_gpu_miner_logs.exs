defmodule MiningRigMonitor.Repo.Migrations.CreateCpuGpuMinerLogs do
  use Ecto.Migration

  def change do
    create table(:cpu_gpu_miner_logs) do
      add :cpu_gpu_miner_id, references(:cpu_gpu_miners)

      add :cpu_temp, :integer
      add :cpu_hashrate, :integer
      add :cpu_hashrate_uom, :string
      add :cpu_algorithm, :string
      add :cpu_coin_name, :string

      add :gpu_1_core_temp, :integer
      add :gpu_2_core_temp, :integer
      add :gpu_3_core_temp, :integer
      add :gpu_4_core_temp, :integer
      add :gpu_5_core_temp, :integer
      add :gpu_6_core_temp, :integer
      add :gpu_7_core_temp, :integer
      add :gpu_8_core_temp, :integer

      add :gpu_1_mem_temp, :integer
      add :gpu_2_mem_temp, :integer
      add :gpu_3_mem_temp, :integer
      add :gpu_4_mem_temp, :integer
      add :gpu_5_mem_temp, :integer
      add :gpu_6_mem_temp, :integer
      add :gpu_7_mem_temp, :integer
      add :gpu_8_mem_temp, :integer

      add :gpu_1_hashrate_1, :integer
      add :gpu_2_hashrate_1, :integer
      add :gpu_3_hashrate_1, :integer
      add :gpu_4_hashrate_1, :integer
      add :gpu_5_hashrate_1, :integer
      add :gpu_6_hashrate_1, :integer
      add :gpu_7_hashrate_1, :integer
      add :gpu_8_hashrate_1, :integer

      add :gpu_1_hashrate_2, :integer
      add :gpu_2_hashrate_2, :integer
      add :gpu_3_hashrate_2, :integer
      add :gpu_4_hashrate_2, :integer
      add :gpu_5_hashrate_2, :integer
      add :gpu_6_hashrate_2, :integer
      add :gpu_7_hashrate_2, :integer
      add :gpu_8_hashrate_2, :integer

      add :gpu_1_core_clock, :integer
      add :gpu_2_core_clock, :integer
      add :gpu_3_core_clock, :integer
      add :gpu_4_core_clock, :integer
      add :gpu_5_core_clock, :integer
      add :gpu_6_core_clock, :integer
      add :gpu_7_core_clock, :integer
      add :gpu_8_core_clock, :integer

      add :gpu_1_mem_clock, :integer
      add :gpu_2_mem_clock, :integer
      add :gpu_3_mem_clock, :integer
      add :gpu_4_mem_clock, :integer
      add :gpu_5_mem_clock, :integer
      add :gpu_6_mem_clock, :integer
      add :gpu_7_mem_clock, :integer
      add :gpu_8_mem_clock, :integer

      add :gpu_1_power, :integer
      add :gpu_2_power, :integer
      add :gpu_3_power, :integer
      add :gpu_4_power, :integer
      add :gpu_5_power, :integer
      add :gpu_6_power, :integer
      add :gpu_7_power, :integer
      add :gpu_8_power, :integer

      add :gpu_algorithm_1, :string
      add :gpu_algorithm_2, :string

      add :gpu_hashrate_uom_1, :string
      add :gpu_hashrate_uom_2, :string

      add :gpu_coin_name_1, :string
      add :gpu_coin_name_2, :string

      add :lan_ip, :string
      add :wan_ip, :string

      timestamps(type: :utc_datetime)
    end
  end
end
