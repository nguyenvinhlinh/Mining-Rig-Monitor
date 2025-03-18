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
        command_argument: "some command_argument",
        cpu_gpu_miner_id: 42,
        software_name: "some software_name",
        software_version: "some software_version"
      })
      |> MiningRigMonitor.CpuGpuMinerPlaybooks.create_cpu_gpu_miner_playbook()

    cpu_gpu_miner_playbook
  end
end
