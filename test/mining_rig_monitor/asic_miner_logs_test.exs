defmodule MiningRigMonitor.AsicMinerLogsTest do
  use MiningRigMonitor.DataCase

  alias MiningRigMonitor.AsicMinerLogs

  describe "asic_miner_logs" do
    alias MiningRigMonitor.AsicMinerLogs.AsicMinerLog

    import MiningRigMonitor.AsicMinerLogsFixtures

    @invalid_attrs %{}

    test "list_asic_miner_logs/0 returns all asic_miner_logs" do
      asic_miner_log = asic_miner_log_fixture()
      assert AsicMinerLogs.list_asic_miner_logs() == [asic_miner_log]
    end

    test "get_asic_miner_log!/1 returns the asic_miner_log with given id" do
      asic_miner_log = asic_miner_log_fixture()
      assert AsicMinerLogs.get_asic_miner_log!(asic_miner_log.id) == asic_miner_log
    end

    test "create_asic_miner_log/1 with valid data creates a asic_miner_log" do
      valid_attrs = %{}

      assert {:ok, %AsicMinerLog{} = asic_miner_log} = AsicMinerLogs.create_asic_miner_log(valid_attrs)
    end

    test "create_asic_miner_log/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = AsicMinerLogs.create_asic_miner_log(@invalid_attrs)
    end

    test "update_asic_miner_log/2 with valid data updates the asic_miner_log" do
      asic_miner_log = asic_miner_log_fixture()
      update_attrs = %{}

      assert {:ok, %AsicMinerLog{} = asic_miner_log} = AsicMinerLogs.update_asic_miner_log(asic_miner_log, update_attrs)
    end

    test "update_asic_miner_log/2 with invalid data returns error changeset" do
      asic_miner_log = asic_miner_log_fixture()
      assert {:error, %Ecto.Changeset{}} = AsicMinerLogs.update_asic_miner_log(asic_miner_log, @invalid_attrs)
      assert asic_miner_log == AsicMinerLogs.get_asic_miner_log!(asic_miner_log.id)
    end

    test "delete_asic_miner_log/1 deletes the asic_miner_log" do
      asic_miner_log = asic_miner_log_fixture()
      assert {:ok, %AsicMinerLog{}} = AsicMinerLogs.delete_asic_miner_log(asic_miner_log)
      assert_raise Ecto.NoResultsError, fn -> AsicMinerLogs.get_asic_miner_log!(asic_miner_log.id) end
    end

    test "change_asic_miner_log/1 returns a asic_miner_log changeset" do
      asic_miner_log = asic_miner_log_fixture()
      assert %Ecto.Changeset{} = AsicMinerLogs.change_asic_miner_log(asic_miner_log)
    end
  end
end
