defmodule MiningRigMonitor.CpuGpuMinersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `MiningRigMonitor.CpuGpuMiners` context.
  """

  @doc """
  Generate a cpu_gpu_miner.
  """
  def cpu_gpu_miner_fixture(attrs \\ %{}) do
    {:ok, cpu_gpu_miner} =
      attrs
      |> Enum.into(%{
        api_code: "some api_code",
        cpu_1_name: "some cpu_1_name",
        cpu_2_name: "some cpu_2_name",
        gpu_1_name: "some gpu_1_name",
        gpu_2_name: "some gpu_2_name",
        gpu_3_name: "some gpu_3_name",
        gpu_4_name: "some gpu_4_name",
        gpu_5_name: "some gpu_5_name",
        gpu_6_name: "some gpu_6_name",
        gpu_7_name: "some gpu_7_name",
        gpu_8_name: "some gpu_8_name",
        name: "some name",
        ram_size: "some ram_size"
      })
      |> MiningRigMonitor.CpuGpuMiners.create_cpu_gpu_miner()

    cpu_gpu_miner
  end
end
