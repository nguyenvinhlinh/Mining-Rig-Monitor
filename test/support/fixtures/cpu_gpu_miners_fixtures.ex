defmodule MiningRigMonitor.CpuGpuMinersFixtures do
  alias MiningRigMonitor.CpuGpuMiners
  require Logger
  @moduledoc """
  This module defines test helpers for creating
  entities via the `MiningRigMonitor.CpuGpuMiners` context.
  """

  @doc """
  Generate a cpu_gpu_miner.
  """
  def cpu_gpu_miner_fixture(attrs \\ %{}) do
    Logger.warning("[#{__MODULE__}] cpu_gpu_miner_fixture/1 deprecated")
    {:ok, cpu_gpu_miner} = attrs
    |> Enum.into(
      %{
        name: "some name", api_code: "some api_code",
        cpu_name: "some cpu_name", ram_size: "some ram_size",
        gpu_1_name: "some gpu_1_name", gpu_2_name: "some gpu_2_name",
        gpu_3_name: "some gpu_3_name", gpu_4_name: "some gpu_4_name",
        gpu_5_name: "some gpu_5_name", gpu_6_name: "some gpu_6_name",
        gpu_7_name: "some gpu_7_name", gpu_8_name: "some gpu_8_name",
      })
    |> MiningRigMonitor.CpuGpuMiners.create_cpu_gpu_miner()

    cpu_gpu_miner
  end

  def cpu_gpu_miner_not_activated_fixture(attrs \\ %{}) do
    {:ok, cpu_gpu_miner} = attrs
    |> Enum.into(%{name: "cpu_gpu_miner name", api_code: "cpu_gpu_miner api_code", activated: false})
    |> CpuGpuMiners.create_cpu_gpu_miner_by_commander()

    cpu_gpu_miner
  end

  def cpu_gpu_miner_activated_fixture(attrs \\ %{}) do
    attrs_mod = attrs
    |> Enum.into(
      %{
        motherboard_name: "MSI B650",
        cpu_name: "AMD 7950x3D", ram_size: "128GB",
        gpu_1_name: "MSI 3080 Suprim", gpu_2_name: "gpu_2_name", gpu_3_name: "gpu_3_name", gpu_4_name: "gpu_4_name",
        gpu_5_name: "gpu_5_name", gpu_6_name: "gpu_6_name", gpu_7_name: "gpu_7_name", gpu_8_name: "gpu_8_name",
        activated: true
      })

    cpu_gpu_miner_not_activated = cpu_gpu_miner_not_activated_fixture()
    {:ok, cpu_gpu_miner_activated} = CpuGpuMiners.update_cpu_gpu_miner_by_sentry(cpu_gpu_miner_not_activated, attrs_mod)
    cpu_gpu_miner_activated
  end
end
