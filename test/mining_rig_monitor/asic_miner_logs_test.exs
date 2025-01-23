defmodule MiningRigMonitor.AsicMinerLogsTest do
  use MiningRigMonitor.DataCase

  import MiningRigMonitor.AsicMinersFixtures

  alias MiningRigMonitor.AsicMinerLogs

  describe "asic_miner_logs" do
    alias MiningRigMonitor.AsicMinerLogs.AsicMinerLog
    import MiningRigMonitor.AsicMinerLogsFixtures

    @invalid_attrs %{"asic_miner_id" => nil}
    setup do
      %{asic_miner: asic_miner_fixture_by_commander()}
    end

    test "create_asic_miner_log/1 with valid data creates a asic_miner_log", %{asic_miner: asic_miner} do
      valid_attrs = %{"asic_miner_id" => asic_miner.id,
                      "hashrate_5_min" => 10.2,
                      "hashrate_uom" => "G",
                      "uptime" => "01:04:29:02",
                      "pool_1_address" => "pool_1_address",
                      "pool_1_user" => "pool_1_user",
                      "pool_1_state" => "Connected",
                      "hashboard_1_temp_1" => "60",
                      "fan_1_speed" => 5000,
                      "lan_ip" => "192.168.1.20",
                      "coin_name" => "kaspa",
                      "power" => 3500
                     }
      assert {:ok, %AsicMinerLog{} = _asic_miner_log} = AsicMinerLogs.create_asic_miner_log(valid_attrs)
    end

    test "create_asic_miner_log/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = AsicMinerLogs.create_asic_miner_log(@invalid_attrs)
    end

    test "change_asic_miner_log/1 returns a asic_miner_log changeset", %{asic_miner: asic_miner} do
      asic_miner_log = asic_miner_log_fixture(%{"asic_miner_id" => asic_miner.id})
      assert %Ecto.Changeset{} = AsicMinerLogs.change_asic_miner_log(asic_miner_log)
    end
  end
end
