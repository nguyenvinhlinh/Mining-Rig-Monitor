defmodule MiningRigMonitor.AsicMinersTest do
  use MiningRigMonitor.DataCase

  alias MiningRigMonitor.AsicMiners

  describe "asic_miners" do
    alias MiningRigMonitor.AsicMiners.AsicMiner

    import MiningRigMonitor.AsicMinersFixtures

    @invalid_attrs %{"name" => nil, "api_code" => nil, "firmware_version" => nil, "software_version" => nil, "model" => nil, "model_variant" => nil}

    test "get_asic_miner!/1 returns the asic_miner with given id" do
      asic_miner = asic_miner_fixture_by_commander()
      assert AsicMiners.get_asic_miner!(asic_miner.id) == asic_miner
    end

    test "create_asic_miner_by_commander/1 with valid data creates a asic_miner" do
      valid_attrs = %{"name" => "some name"}

      assert {:ok, %AsicMiner{} = asic_miner} = AsicMiners.create_asic_miner_by_commander(valid_attrs)
      assert asic_miner.name == "some name"
      assert asic_miner.activated == false
      refute Kernel.is_nil(asic_miner.api_code)
    end

    test "create_asic_miner_by_commander/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = AsicMiners.create_asic_miner_by_commander(@invalid_attrs)
    end

    test "update_asic_miner_by_commander/2 with valid data updates the asic_miner" do
      asic_miner = asic_miner_fixture_by_commander()
      update_attrs = %{name: "new updated name"}

      assert {:ok, %AsicMiner{} = asic_miner} = AsicMiners.update_asic_miner_by_commander(asic_miner, update_attrs)
      assert asic_miner.name == "new updated name"
    end

    test "update_asic_miner_by_commander/2 with invalid data returns error changeset" do
      asic_miner = asic_miner_fixture_by_commander()
      assert {:error, %Ecto.Changeset{}} = AsicMiners.update_asic_miner_by_commander(asic_miner, @invalid_attrs)
      assert asic_miner == AsicMiners.get_asic_miner!(asic_miner.id)
    end

    test "delete_asic_miner/1 deletes the asic_miner" do
      asic_miner = asic_miner_fixture_by_commander()
      assert {:ok, %AsicMiner{}} = AsicMiners.delete_asic_miner(asic_miner)
      assert_raise Ecto.NoResultsError, fn -> AsicMiners.get_asic_miner!(asic_miner.id) end
    end

    test "change_asic_miner/1 returns a asic_miner changeset" do
      asic_miner = asic_miner_fixture_by_commander()
      assert %Ecto.Changeset{} = AsicMiners.change_asic_miner(asic_miner)
    end

    test "get_asic_miner_by_api_code_list with valid api_code list" do
      asic_miner_1 = asic_miner_fixture_by_commander()
      asic_miner_2 = asic_miner_fixture_by_commander()
      api_code_list = [asic_miner_1.api_code, asic_miner_2.api_code]
      asic_miner_list = AsicMiners.get_asic_miner_by_api_code_list(api_code_list)
      assert asic_miner_1 in asic_miner_list
      assert asic_miner_2 in asic_miner_list
    end

    @tag runonly: true
    test "get_asic_miner_by_api_code_list with invalid api_code list" do
      api_code_list = ["invalid api_code 1", "invalid api_code 2"]
      asic_miner_list = AsicMiners.get_asic_miner_by_api_code_list(api_code_list)
      assert asic_miner_list == []
    end


  end
end
