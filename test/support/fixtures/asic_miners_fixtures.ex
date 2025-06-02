defmodule MiningRigMonitor.AsicMinersFixtures do
  require Logger
  @moduledoc """
  This module defines test helpers for creating
  entities via the `MiningRigMonitor.AsicMiners` context.
  """

  @doc """
  Generate a asic_miner.
  """

  def asic_miner_fixture_by_commander(attrs \\ %{}) do
    Logger.warning("[#{__MODULE__}] asic_miner_fixture_by_commander/1 change to asic_miner_not_activated_fixture")
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

  def asic_miner_not_activated_fixture(attrs \\ %{}) do
    default_map = %{
      "name" => "Thanh Long",
      "api_code" => UUID.uuid1(),
      "activated" => false,
      "asic_expected_status" => "on",
      "light_expected_status" => "off",
    }

    {:ok, asic_miner} = attrs
    |> Enum.into(default_map)
    |> MiningRigMonitor.AsicMiners.create_asic_miner_by_commander()
    asic_miner
  end

  def asic_miner_activated_fixture(attrs \\ %{}) do
    asic_miner = asic_miner_not_activated_fixture(%{"name" => "Bach Ho", "api_code" => UUID.uuid1()})
    default_map = %{
      "firmware_version" => "1.0.0",
      "software_version" => "2.0.0",
      "model" => "KS5L",
      "model_variant" => "20TH",
      "activated" => true
    }

    attrs_mod = attrs
    |> Enum.into(default_map)

    {:ok, asic_miner_mod} = MiningRigMonitor.AsicMiners.update_asic_miner_by_sentry(asic_miner, attrs_mod)
    asic_miner_mod
  end
end
