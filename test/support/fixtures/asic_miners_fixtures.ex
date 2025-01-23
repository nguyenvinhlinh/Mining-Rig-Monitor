defmodule MiningRigMonitor.AsicMinersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `MiningRigMonitor.AsicMiners` context.
  """

  @doc """
  Generate a asic_miner.
  """
  def asic_miner_fixture_by_commander(attrs \\ %{}) do
    {:ok, asic_miner} =
      attrs
      |> Enum.into(%{"name" => "some name"})
      |> MiningRigMonitor.AsicMiners.create_asic_miner_by_commander()

    asic_miner
  end
end
