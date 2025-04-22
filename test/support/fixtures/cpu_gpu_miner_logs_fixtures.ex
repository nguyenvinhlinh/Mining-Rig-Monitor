defmodule MiningRigMonitor.CpuGpuMinerLogsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `MiningRigMonitor.CpuGpuMinerLogs` context.
  """

  @doc """
  Generate a cpu_gpu_miner_log.
  """
  def cpu_gpu_miner_log_fixture(attrs \\ %{}) do
    cpu_gpu_miner = MiningRigMonitor.CpuGpuMinersFixtures.cpu_gpu_miner_fixture()
    {:ok, cpu_gpu_miner_log} =
      attrs
      |> Enum.into(%{
          cpu_gpu_miner_id: cpu_gpu_miner.id,
          cpu_temp: 10,
          cpu_hashrate: 11,
          cpu_hashrate_uom: "H/s",
          cpu_algorithm: "RandomX",
          cpu_coin_name: "Monero",
          cpu_pool_address: "cpu_pool_address",
          cpu_wallet_address: "cpu_wallet_address",
          cpu_power: 150,

          gpu_1_core_temp: 11,
          gpu_2_core_temp: 12,
          gpu_3_core_temp: 13,
          gpu_4_core_temp: 14,
          gpu_5_core_temp: 15,
          gpu_6_core_temp: 16,
          gpu_7_core_temp: 17,
          gpu_8_core_temp: 18,

          gpu_1_mem_temp: 21,
          gpu_2_mem_temp: 22,
          gpu_3_mem_temp: 23,
          gpu_4_mem_temp: 24,
          gpu_5_mem_temp: 25,
          gpu_6_mem_temp: 26,
          gpu_7_mem_temp: 27,
          gpu_8_mem_temp: 28,

          gpu_1_hashrate_1: 31,
          gpu_2_hashrate_1: 32,
          gpu_3_hashrate_1: 33,
          gpu_4_hashrate_1: 34,
          gpu_5_hashrate_1: 35,
          gpu_6_hashrate_1: 36,
          gpu_7_hashrate_1: 37,
          gpu_8_hashrate_1: 38,

          gpu_1_hashrate_2: 41,
          gpu_2_hashrate_2: 42,
          gpu_3_hashrate_2: 43,
          gpu_4_hashrate_2: 44,
          gpu_5_hashrate_2: 45,
          gpu_6_hashrate_2: 46,
          gpu_7_hashrate_2: 47,
          gpu_8_hashrate_2: 48,

          gpu_1_core_clock: 51,
          gpu_2_core_clock: 52,
          gpu_3_core_clock: 53,
          gpu_4_core_clock: 54,
          gpu_5_core_clock: 55,
          gpu_6_core_clock: 56,
          gpu_7_core_clock: 57,
          gpu_8_core_clock: 58,

          gpu_1_mem_clock: 61,
          gpu_2_mem_clock: 62,
          gpu_3_mem_clock: 63,
          gpu_4_mem_clock: 64,
          gpu_5_mem_clock: 65,
          gpu_6_mem_clock: 66,
          gpu_7_mem_clock: 67,
          gpu_8_mem_clock: 68,

          gpu_1_power: 71,
          gpu_2_power: 72,
          gpu_3_power: 73,
          gpu_4_power: 74,
          gpu_5_power: 75,
          gpu_6_power: 76,
          gpu_7_power: 77,
          gpu_8_power: 78,

          gpu_1_fan: 81,
          gpu_2_fan: 82,
          gpu_3_fan: 83,
          gpu_4_fan: 84,
          gpu_5_fan: 85,
          gpu_6_fan: 86,
          gpu_7_fan: 87,
          gpu_8_fan: 88,

          gpu_fan_uom: "%",


          gpu_algorithm_1: "Ethash",
          gpu_algorithm_2: "KnightHash",

          gpu_hashrate_uom_1: "MH/s",
          gpu_hashrate_uom_2: "GH/s",

          gpu_coin_name_1: "Ethereum",
          gpu_coin_name_2: "Kaspa",

          gpu_pool_address_1: "gpu_pool_address_1",
          gpu_pool_address_2: "gpu_pool_address_2",

          gpu_wallet_address_1: "gpu_wallet_address_1",
          gpu_wallet_address_2: "gpu_wallet_address_2",

          lan_ip: "192.168.1.5",
          wan_ip: "170.171.172.173",
          uptime: "1 Day, 2 Hours"
        })
      |> MiningRigMonitor.CpuGpuMinerLogs.create_cpu_gpu_miner_log()

      cpu_gpu_miner_log
  end
end
