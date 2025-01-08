defmodule MiningRigMonitor.AsicMinersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `MiningRigMonitor.AsicMiners` context.
  """

  @doc """
  Generate a asic_miner.
  """
  def asic_miner_fixture(attrs \\ %{}) do
    {:ok, asic_miner} =
      attrs
      |> Enum.into(%{
        api_code: "some api_code",
        firmware_version: "some firmware_version",
        model: "some model",
        model_variant: "some model_variant",
        name: "some name",
        software_version: "some software_version"
      })
      |> MiningRigMonitor.AsicMiners.create_asic_miner()

    asic_miner
  end
end
