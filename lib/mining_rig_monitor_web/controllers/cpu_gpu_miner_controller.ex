defmodule MiningRigMonitorWeb.CpuGpuMinerController do
  use MiningRigMonitorWeb, :controller

  alias MiningRigMonitor.CpuGpuMiners

  action_fallback MiningRigMonitorWeb.FallbackController

  def update_cpu_gpu_miner_specs(conn, params) do
    cpu_gpu_miner = conn.assigns.cpu_gpu_miner
    params_mod = Map.put(params, "activated", true)

    case CpuGpuMiners.update_cpu_gpu_miner_by_sentry(cpu_gpu_miner, params_mod) do
      {:ok, cpu_gpu_miner} ->
        Phoenix.PubSub.broadcast(MiningRigMonitor.PubSub, "flash_index",
          {:flash_index, :info, "CPU/GPU miner id##{cpu_gpu_miner.id} name: #{cpu_gpu_miner.name} is activated!"})

        Phoenix.PubSub.broadcast(MiningRigMonitor.PubSub, "cpu_gpu_miner_index_channel",
          {:cpu_gpu_miner_index_channel, :create_or_update, cpu_gpu_miner})

        Phoenix.PubSub.broadcast(MiningRigMonitor.PubSub,
          "cpu_gpu_miner_channel:#{cpu_gpu_miner.id}",
          {:cpu_gpu_miner_channel, :update_asic_miner, cpu_gpu_miner})

        json(conn, nil)
      {:error, changeset} -> {:error, changeset}
    end
  end
end
