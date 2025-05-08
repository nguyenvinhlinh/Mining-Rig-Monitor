defmodule MiningRigMonitor.AsicMinersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `MiningRigMonitor.AsicMiners` context.
  """

  @doc """
  Generate a asic_miner.
  """
  def asic_miner_fixture_by_commander(attrs \\ %{}) do
    default_map = %{
      "name" => "asic_name",
      "api_code" => "api_code",
      "activated" => false,
      "asic_expected_status" => "on",
      "light_expected_status" => "off",
    }

    {:ok, asic_miner} = attrs
    |> Enum.into(default_map)
    |> MiningRigMonitor.AsicMiners.create_asic_miner_by_commander()

    asic_miner
  end
end
