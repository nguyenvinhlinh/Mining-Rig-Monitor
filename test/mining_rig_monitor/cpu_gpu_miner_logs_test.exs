defmodule MiningRigMonitor.CpuGpuMinerLogsTest do
  use MiningRigMonitor.DataCase

  alias MiningRigMonitor.CpuGpuMinerLogs

  describe "cpu_gpu_miner_logs" do
    alias MiningRigMonitor.CpuGpuMinerLogs.CpuGpuMinerLog

    import MiningRigMonitor.CpuGpuMinerLogsFixtures

    @invalid_attrs %{}

    test "get_cpu_gpu_miner_log!/1 returns the cpu_gpu_miner_log with given id" do
      cpu_gpu_miner_log = cpu_gpu_miner_log_fixture()
      assert CpuGpuMinerLogs.get_cpu_gpu_miner_log!(cpu_gpu_miner_log.id) == cpu_gpu_miner_log
    end

    test "create_cpu_gpu_miner_log/1 with valid data creates a cpu_gpu_miner_log" do
      cpu_gpu_miner = MiningRigMonitor.CpuGpuMinersFixtures.cpu_gpu_miner_fixture()
      valid_attrs = %{
        cpu_gpu_miner_id: cpu_gpu_miner.id
      }

      assert {:ok, %CpuGpuMinerLog{} = cpu_gpu_miner_log} = CpuGpuMinerLogs.create_cpu_gpu_miner_log(valid_attrs)
    end

    test "create_cpu_gpu_miner_log/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = CpuGpuMinerLogs.create_cpu_gpu_miner_log(@invalid_attrs)
    end

    test "change_cpu_gpu_miner_log/1 returns a cpu_gpu_miner_log changeset" do
      cpu_gpu_miner_log = cpu_gpu_miner_log_fixture()
      assert %Ecto.Changeset{} = CpuGpuMinerLogs.change_cpu_gpu_miner_log(cpu_gpu_miner_log)
    end
  end
end
