defmodule MiningRigMonitor.AsicMinersTest do
  use MiningRigMonitor.DataCase
  alias MiningRigMonitor.AsicMiners
  alias MiningRigMonitor.AsicMiners.AsicMiner
  import MiningRigMonitor.AsicMinersFixtures
  describe "asic_miners" do
    @commander_invalid_attrs %{"name" => nil, "asic_expected_status" => "invalid status", "light_expected_status" => "invalid status"}

    @commander_valid_attrs %{"name" => "Thanh Long", "activated" => false, "api_code" => "api_code",
                             "asic_expected_status" => "on",
                             "light_expected_status" => "off"}

    test "get_asic_miner!/1 returns the asic_miner with given id" do
      asic_miner = asic_miner_fixture_by_commander()
      assert AsicMiners.get_asic_miner!(asic_miner.id) == asic_miner
    end

    test "create_asic_miner_by_commander/1 with valid data creates a asic_miner" do
      assert {:ok, %AsicMiner{} = asic_miner} = AsicMiners.create_asic_miner_by_commander(@commander_valid_attrs)
      assert asic_miner.name == "Thanh Long"
      assert asic_miner.activated == false
      assert asic_miner.api_code == "api_code"
      assert asic_miner.asic_expected_status == "on"
      assert asic_miner.light_expected_status == "off"
    end

    test "create_asic_miner_by_commander/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = AsicMiners.create_asic_miner_by_commander(@commander_invalid_attrs)
    end

    test "update_asic_miner_by_commander/2 with valid data updates the asic_miner" do
      asic_miner = asic_miner_fixture_by_commander()
      update_attrs = %{name: "Bach Ho", asic_expected_status: "off", light_expected_status: "on"}

      assert {:ok, %AsicMiner{} = asic_miner} = AsicMiners.update_asic_miner_by_commander(asic_miner, update_attrs)
      assert asic_miner.name == "Bach Ho"
      assert asic_miner.asic_expected_status == "off"
      assert asic_miner.light_expected_status == "on"
    end

    test "update_asic_miner_by_commander/2 with invalid data returns error changeset" do
      asic_miner = asic_miner_fixture_by_commander()
      assert {:error, %Ecto.Changeset{}} = AsicMiners.update_asic_miner_by_commander(asic_miner, @commander_invalid_attrs)
      assert asic_miner == AsicMiners.get_asic_miner!(asic_miner.id)
    end

    test "delete_asic_miner/1 deletes the asic_miner" do
      asic_miner = asic_miner_fixture_by_commander()
      assert {:ok, %AsicMiner{}} = AsicMiners.delete_asic_miner(asic_miner)
      assert_raise Ecto.NoResultsError, fn -> AsicMiners.get_asic_miner!(asic_miner.id) end
    end

    test "get_asic_miner_by_api_code with valid api_code" do
      asic_miner = asic_miner_fixture_by_commander()
      test_asic_miner = AsicMiners.get_asic_miner_by_api_code(asic_miner.api_code)
      assert asic_miner == test_asic_miner
    end

    test "get_asic_miner_by_api_code with invalid api_code" do
      test_asic_miner = AsicMiners.get_asic_miner_by_api_code("invalid api_code")
      assert Kernel.is_nil(test_asic_miner)
    end

    test "get_asic_miner_by_api_code_list with valid api_code list" do
      asic_miner_1 = asic_miner_fixture_by_commander(%{"name" => "Thanh Long", "api_code" => "api_code_1"})
      asic_miner_2 = asic_miner_fixture_by_commander(%{"name" => "Bach Ho", "api_code" => "api_code_2"})
      api_code_list = [asic_miner_1.api_code, asic_miner_2.api_code]
      asic_miner_list = AsicMiners.get_asic_miner_by_api_code_list(api_code_list)
      assert asic_miner_1 in asic_miner_list
      assert asic_miner_2 in asic_miner_list
    end

    test "get_asic_miner_by_api_code_list with invalid api_code list" do
      api_code_list = ["invalid api_code 1", "invalid api_code 2"]
      asic_miner_list = AsicMiners.get_asic_miner_by_api_code_list(api_code_list)
      assert asic_miner_list == []
    end
  end
end
