defmodule MiningRigMonitor.CpuGpuMinerPlaybooksFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `MiningRigMonitor.CpuGpuMinerPlaybooks` context.
  """

  @doc """
  Generate a cpu_gpu_miner_playbook.
  """
  def cpu_gpu_miner_playbook_fixture(attrs \\ %{}) do
    {:ok, cpu_gpu_miner_playbook} =
      attrs
      |> Enum.into(%{
          command_argument: "--no-color --url $CPU_POOL --algo rx/0 --user $CPU_WALLET --pass $WORKER_NAME",
          software_name: "XMRig",
          software_version: "6.22.2",
          cpu_coin_name: "Monero",
          cpu_algorithm: "RandomX"
      })
      |> MiningRigMonitor.CpuGpuMinerPlaybooks.create_cpu_gpu_miner_playbook()

    cpu_gpu_miner_playbook
  end
end
