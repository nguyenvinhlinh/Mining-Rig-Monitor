defmodule MiningRigMonitor.AsicMinersTest do
  use MiningRigMonitor.DataCase

  alias MiningRigMonitor.AsicMiners

  describe "asic_miners" do
    alias MiningRigMonitor.AsicMiners.AsicMiner

    import MiningRigMonitor.AsicMinersFixtures

    @invalid_attrs %{name: nil, api_code: nil, firmware_version: nil, software_version: nil, model: nil, model_variant: nil}

    test "list_asic_miners/0 returns all asic_miners" do
      asic_miner = asic_miner_fixture()
      assert AsicMiners.list_asic_miners() == [asic_miner]
    end

    test "get_asic_miner!/1 returns the asic_miner with given id" do
      asic_miner = asic_miner_fixture()
      assert AsicMiners.get_asic_miner!(asic_miner.id) == asic_miner
    end

    test "create_asic_miner/1 with valid data creates a asic_miner" do
      valid_attrs = %{name: "some name", api_code: "some api_code", firmware_version: "some firmware_version", software_version: "some software_version", model: "some model", model_variant: "some model_variant"}

      assert {:ok, %AsicMiner{} = asic_miner} = AsicMiners.create_asic_miner(valid_attrs)
      assert asic_miner.name == "some name"
      assert asic_miner.api_code == "some api_code"
      assert asic_miner.firmware_version == "some firmware_version"
      assert asic_miner.software_version == "some software_version"
      assert asic_miner.model == "some model"
      assert asic_miner.model_variant == "some model_variant"
    end

    test "create_asic_miner/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = AsicMiners.create_asic_miner(@invalid_attrs)
    end

    test "update_asic_miner/2 with valid data updates the asic_miner" do
      asic_miner = asic_miner_fixture()
      update_attrs = %{name: "some updated name", api_code: "some updated api_code", firmware_version: "some updated firmware_version", software_version: "some updated software_version", model: "some updated model", model_variant: "some updated model_variant"}

      assert {:ok, %AsicMiner{} = asic_miner} = AsicMiners.update_asic_miner(asic_miner, update_attrs)
      assert asic_miner.name == "some updated name"
      assert asic_miner.api_code == "some updated api_code"
      assert asic_miner.firmware_version == "some updated firmware_version"
      assert asic_miner.software_version == "some updated software_version"
      assert asic_miner.model == "some updated model"
      assert asic_miner.model_variant == "some updated model_variant"
    end

    test "update_asic_miner/2 with invalid data returns error changeset" do
      asic_miner = asic_miner_fixture()
      assert {:error, %Ecto.Changeset{}} = AsicMiners.update_asic_miner(asic_miner, @invalid_attrs)
      assert asic_miner == AsicMiners.get_asic_miner!(asic_miner.id)
    end

    test "delete_asic_miner/1 deletes the asic_miner" do
      asic_miner = asic_miner_fixture()
      assert {:ok, %AsicMiner{}} = AsicMiners.delete_asic_miner(asic_miner)
      assert_raise Ecto.NoResultsError, fn -> AsicMiners.get_asic_miner!(asic_miner.id) end
    end

    test "change_asic_miner/1 returns a asic_miner changeset" do
      asic_miner = asic_miner_fixture()
      assert %Ecto.Changeset{} = AsicMiners.change_asic_miner(asic_miner)
    end
  end
end
