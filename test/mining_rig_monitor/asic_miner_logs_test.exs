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
      valid_attrs = %{"asic_miner_id" => asic_miner.id}
      assert {:ok, %AsicMinerLog{} = asic_miner_log} = AsicMinerLogs.create_asic_miner_log(valid_attrs)
    end

    test "create_asic_miner_log/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = AsicMinerLogs.create_asic_miner_log(@invalid_attrs)
    end

    test "change_asic_miner_log/1 returns a asic_miner_log changeset", %{asic_miner: asic_miner} do
      asic_miner_log = asic_miner_log_fixture(%{asic_miner_id: asic_miner.id})
      assert %Ecto.Changeset{} = AsicMinerLogs.change_asic_miner_log(asic_miner_log)
    end
  end
end
