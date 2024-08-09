defmodule MiningRigMonitorWeb.MiningRigController do
  use MiningRigMonitorWeb, :controller

  alias MiningRigMonitor.MiningRigs

  action_fallback MiningRigMonitorWeb.FallbackController

  def update_mining_rig_asic(conn, params) do
    new_params = params
    |> Map.put("mining_rig_id", conn.assigns.mining_rig.id)

    mining_rig = conn.assigns.mining_rig

    case MiningRigs.update_asic_mining_rig(mining_rig, new_params) do
      {:ok, mining_rig} ->
        topic_name = "mining_rig:#{mining_rig.id}"
        Phoenix.PubSub.broadcast(MiningRigMonitor.PubSub, topic_name, {:mining_rig_updated, mining_rig})
        json(conn, :ok)
      {:error, changeset} -> {:error, changeset}
    end
  end
end
