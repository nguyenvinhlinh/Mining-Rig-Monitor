defmodule MiningRigMonitorWeb.AsicMinerController do
  use MiningRigMonitorWeb, :controller

  alias MiningRigMonitor.AsicMiners

  action_fallback MiningRigMonitorWeb.FallbackController

  def update_asic_miner_specs(conn, params) do
    asic_miner = conn.assigns.asic_miner
    params_mod = Map.put(params, "activated", true)

    case AsicMiners.update_asic_miner_by_sentry(asic_miner, params_mod) do
      {:ok, _asic_miner} ->  json(conn, :ok)
      {:error, changeset} -> {:error, changeset}
    end
  end
end
