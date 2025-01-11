defmodule MiningRigMonitorWeb.AsicMinerLogController do
  use MiningRigMonitorWeb, :controller

  alias MiningRigMonitor.AsicMinerLogs

  action_fallback MiningRigMonitorWeb.FallbackController

  def create(conn, asic_miner_log_params) do
    asic_miner = conn.assigns.asic_miner
    asic_miner_log_params_mod = Map.put(asic_miner_log_params, "asic_miner_id", asic_miner.id)
    case AsicMinerLogs.create_asic_miner_log(asic_miner_log_params_mod) do
      {:ok, asic_miner_log} ->
        MiningRigMonitor.GenServer.AsicMinerOperationalIndex.put(asic_miner_log)
        Phoenix.PubSub.broadcast(MiningRigMonitor.PubSub, "asic_miner_index",
          {:asic_miner_index, :create_or_update, asic_miner})
        json(conn, nil)
      {:error, changeset} -> {:error, changeset}
    end
  end
end
