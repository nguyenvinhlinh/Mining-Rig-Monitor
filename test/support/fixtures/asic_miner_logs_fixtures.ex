defmodule MiningRigMonitor.AsicMinerLogsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `MiningRigMonitor.AsicMinerLogs` context.
  """

  @doc """
  Generate a asic_miner_log.
  """
  def asic_miner_log_fixture(attrs \\ %{}) do
    {:ok, asic_miner_log} =
      attrs
      |> Enum.into(%{"hashrate_5_min" => 10.2,
                   "hashrate_uom" => "G",
                   "uptime" => "01:04:29:02",
                   "pool_1_address" => "pool_1_address",
                   "pool_1_user" => "pool_1_user",
                   "pool_1_state" => "Connected",
                   "hashboard_1_temp_1" => "60",
                   "fan_1_speed" => 5000,
                   "lan_ip" => "192.168.1.20",
                   "coin_name" => "kaspa",
                   "power" => 3500 })
      |> MiningRigMonitor.AsicMinerLogs.create_asic_miner_log()
    asic_miner_log
  end
end
