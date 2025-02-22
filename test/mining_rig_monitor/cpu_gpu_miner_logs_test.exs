defmodule MiningRigMonitor.CpuGpuMinerLogsTest do
  use MiningRigMonitor.DataCase

  alias MiningRigMonitor.CpuGpuMinerLogs

  describe "cpu_gpu_miner_logs" do
    alias MiningRigMonitor.CpuGpuMinerLogs.CpuGpuMinerLog

    import MiningRigMonitor.CpuGpuMinerLogsFixtures

    @invalid_attrs %{}

    test "list_cpu_gpu_miner_logs/0 returns all cpu_gpu_miner_logs" do
      cpu_gpu_miner_log = cpu_gpu_miner_log_fixture()
      assert CpuGpuMinerLogs.list_cpu_gpu_miner_logs() == [cpu_gpu_miner_log]
    end

    test "get_cpu_gpu_miner_log!/1 returns the cpu_gpu_miner_log with given id" do
      cpu_gpu_miner_log = cpu_gpu_miner_log_fixture()
      assert CpuGpuMinerLogs.get_cpu_gpu_miner_log!(cpu_gpu_miner_log.id) == cpu_gpu_miner_log
    end

    test "create_cpu_gpu_miner_log/1 with valid data creates a cpu_gpu_miner_log" do
      valid_attrs = %{}

      assert {:ok, %CpuGpuMinerLog{} = cpu_gpu_miner_log} = CpuGpuMinerLogs.create_cpu_gpu_miner_log(valid_attrs)
    end

    test "create_cpu_gpu_miner_log/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = CpuGpuMinerLogs.create_cpu_gpu_miner_log(@invalid_attrs)
    end

    test "update_cpu_gpu_miner_log/2 with valid data updates the cpu_gpu_miner_log" do
      cpu_gpu_miner_log = cpu_gpu_miner_log_fixture()
      update_attrs = %{}

      assert {:ok, %CpuGpuMinerLog{} = cpu_gpu_miner_log} = CpuGpuMinerLogs.update_cpu_gpu_miner_log(cpu_gpu_miner_log, update_attrs)
    end

    test "update_cpu_gpu_miner_log/2 with invalid data returns error changeset" do
      cpu_gpu_miner_log = cpu_gpu_miner_log_fixture()
      assert {:error, %Ecto.Changeset{}} = CpuGpuMinerLogs.update_cpu_gpu_miner_log(cpu_gpu_miner_log, @invalid_attrs)
      assert cpu_gpu_miner_log == CpuGpuMinerLogs.get_cpu_gpu_miner_log!(cpu_gpu_miner_log.id)
    end

    test "delete_cpu_gpu_miner_log/1 deletes the cpu_gpu_miner_log" do
      cpu_gpu_miner_log = cpu_gpu_miner_log_fixture()
      assert {:ok, %CpuGpuMinerLog{}} = CpuGpuMinerLogs.delete_cpu_gpu_miner_log(cpu_gpu_miner_log)
      assert_raise Ecto.NoResultsError, fn -> CpuGpuMinerLogs.get_cpu_gpu_miner_log!(cpu_gpu_miner_log.id) end
    end

    test "change_cpu_gpu_miner_log/1 returns a cpu_gpu_miner_log changeset" do
      cpu_gpu_miner_log = cpu_gpu_miner_log_fixture()
      assert %Ecto.Changeset{} = CpuGpuMinerLogs.change_cpu_gpu_miner_log(cpu_gpu_miner_log)
    end
  end
end
