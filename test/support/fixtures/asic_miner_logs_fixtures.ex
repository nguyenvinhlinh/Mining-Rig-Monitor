defmodule MiningRigMonitor.AsicMinerLogsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `MiningRigMonitor.AsicMinerLogs` context.
  """

  @doc """
  Generate a asic_miner_log.
  """
  def asic_miner_log_fixture(attrs \\ %{}) do
    {:ok, asic_miner_log} =
      attrs
      |> Enum.into(%{

      })
      |> MiningRigMonitor.AsicMinerLogs.create_asic_miner_log()

    asic_miner_log
  end
end
