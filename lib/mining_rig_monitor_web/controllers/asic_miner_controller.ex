defmodule MiningRigMonitorWeb.AsicMinerController do
  use MiningRigMonitorWeb, :controller

  alias MiningRigMonitor.AsicMiners

  action_fallback MiningRigMonitorWeb.FallbackController

  def update_asic_miner_specs(conn, params) do
    asic_miner = conn.assigns.asic_miner
    params_mod = Map.put(params, "activated", true)

    case AsicMiners.update_asic_miner_by_sentry(asic_miner, params_mod) do
      {:ok, asic_miner} ->
        Phoenix.PubSub.broadcast(MiningRigMonitor.PubSub, "flash_index",
          {:flash_index, :info, "ASIC miner id##{asic_miner.id} name: #{asic_miner.name} is activated!"})
        Phoenix.PubSub.broadcast(MiningRigMonitor.PubSub, "asic_miner_index_channel",
          {:asic_miner_index_channel, :create_or_update, asic_miner})
        Phoenix.PubSub.broadcast(MiningRigMonitor.PubSub,
          "asic_miner_channel:#{asic_miner.id}",
          {:asic_miner_channel , :update_asic_miner, asic_miner})

        json(conn, nil)
      {:error, changeset} -> {:error, changeset}
    end
  end

  def get_expected_status(conn, _params) do
    data = conn.assigns.asic_miner
    |> Map.take([:asic_expected_status, :light_expected_status])
    json(conn, data)
  end
end
