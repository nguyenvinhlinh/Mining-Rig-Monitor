defmodule MiningRigMonitor.CpuGpuMinerLogsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `MiningRigMonitor.CpuGpuMinerLogs` context.
  """

  @doc """
  Generate a cpu_gpu_miner_log.
  """
  def cpu_gpu_miner_log_fixture(attrs \\ %{}) do
    {:ok, cpu_gpu_miner_log} =
      attrs
      |> Enum.into(%{

      })
      |> MiningRigMonitor.CpuGpuMinerLogs.create_cpu_gpu_miner_log()

    cpu_gpu_miner_log
  end
end
