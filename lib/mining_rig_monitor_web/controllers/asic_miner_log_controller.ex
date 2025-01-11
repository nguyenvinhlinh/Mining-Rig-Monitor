defmodule MiningRigMonitorWeb.AsicMinerLogController do
  use MiningRigMonitorWeb, :controller

  alias MiningRigMonitor.AsicMinerLogs
  alias MiningRigMonitor.AsicMinerLogs.AsicMinerLog

  action_fallback MiningRigMonitorWeb.FallbackController

  def create(conn, asic_miner_log_params) do
    asic_miner = conn.assigns.asic_miner
    asic_miner_log_params_mod = Map.put(asic_miner_log_params, "asic_miner_id", asic_miner.id)
    case AsicMinerLogs.create_asic_miner_log(asic_miner_log_params_mod) do
      {:ok, _} ->  json(conn, :ok)
      {:error, changeset} -> {:error, changeset}
    end
  end
end
