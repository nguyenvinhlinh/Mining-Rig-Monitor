defmodule MiningRigMonitorWeb.CpuGpuMinerLogController do
  use MiningRigMonitorWeb, :controller

  alias MiningRigMonitor.CpuGpuMinerLogs
  alias MiningRigMonitor.CpuGpuMinerLogs.CpuGpuMinerLog

  action_fallback MiningRigMonitorWeb.FallbackController

  def create(conn, cpu_gpu_miner_log_params) do
    cpu_gpu_miner = conn.assigns.cpu_gpu_miner
    cpu_gpu_miner_log_params_mod = Map.put(cpu_gpu_miner_log_params, "cpu_gpu_miner_id", cpu_gpu_miner.id)
    case CpuGpuMinerLogs.create_cpu_gpu_miner_log(cpu_gpu_miner_log_params_mod) do
      {:ok, cpu_gpu_miner_log} ->
        MiningRigMonitor.GenServer.CpuGpuMinerOperationalIndex.put(cpu_gpu_miner_log)
        Phoenix.PubSub.broadcast(MiningRigMonitor.PubSub,
          "cpu_gpu_miner_operational_channel:#{cpu_gpu_miner.id}",
          {:cpu_gpu_miner_operational_channel , :create_cpu_gpu_miner_log, cpu_gpu_miner_log})
        json(conn, nil)
      {:error, changeset} -> {:error, changeset}
    end
  end
end
