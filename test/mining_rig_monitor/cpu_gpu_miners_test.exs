defmodule MiningRigMonitor.CpuGpuMinersTest do
  use MiningRigMonitor.DataCase

  alias MiningRigMonitor.CpuGpuMiners

  describe "cpu_gpu_miners" do
    alias MiningRigMonitor.CpuGpuMiners.CpuGpuMiner

    import MiningRigMonitor.CpuGpuMinersFixtures

    @invalid_attrs %{name: nil, api_code: nil, cpu_1_name: nil, cpu_2_name: nil, ram_size: nil, gpu_1_name: nil, gpu_2_name: nil, gpu_3_name: nil, gpu_4_name: nil, gpu_5_name: nil, gpu_6_name: nil, gpu_7_name: nil, gpu_8_name: nil}

    test "list_cpu_gpu_miners/0 returns all cpu_gpu_miners" do
      cpu_gpu_miner = cpu_gpu_miner_fixture()
      assert CpuGpuMiners.list_cpu_gpu_miners() == [cpu_gpu_miner]
    end

    test "get_cpu_gpu_miner!/1 returns the cpu_gpu_miner with given id" do
      cpu_gpu_miner = cpu_gpu_miner_fixture()
      assert CpuGpuMiners.get_cpu_gpu_miner!(cpu_gpu_miner.id) == cpu_gpu_miner
    end

    test "create_cpu_gpu_miner/1 with valid data creates a cpu_gpu_miner" do
      valid_attrs = %{name: "some name", api_code: "some api_code", cpu_1_name: "some cpu_1_name", cpu_2_name: "some cpu_2_name", ram_size: "some ram_size", gpu_1_name: "some gpu_1_name", gpu_2_name: "some gpu_2_name", gpu_3_name: "some gpu_3_name", gpu_4_name: "some gpu_4_name", gpu_5_name: "some gpu_5_name", gpu_6_name: "some gpu_6_name", gpu_7_name: "some gpu_7_name", gpu_8_name: "some gpu_8_name"}

      assert {:ok, %CpuGpuMiner{} = cpu_gpu_miner} = CpuGpuMiners.create_cpu_gpu_miner(valid_attrs)
      assert cpu_gpu_miner.name == "some name"
      assert cpu_gpu_miner.api_code == "some api_code"
      assert cpu_gpu_miner.cpu_1_name == "some cpu_1_name"
      assert cpu_gpu_miner.cpu_2_name == "some cpu_2_name"
      assert cpu_gpu_miner.ram_size == "some ram_size"
      assert cpu_gpu_miner.gpu_1_name == "some gpu_1_name"
      assert cpu_gpu_miner.gpu_2_name == "some gpu_2_name"
      assert cpu_gpu_miner.gpu_3_name == "some gpu_3_name"
      assert cpu_gpu_miner.gpu_4_name == "some gpu_4_name"
      assert cpu_gpu_miner.gpu_5_name == "some gpu_5_name"
      assert cpu_gpu_miner.gpu_6_name == "some gpu_6_name"
      assert cpu_gpu_miner.gpu_7_name == "some gpu_7_name"
      assert cpu_gpu_miner.gpu_8_name == "some gpu_8_name"
    end

    test "create_cpu_gpu_miner/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = CpuGpuMiners.create_cpu_gpu_miner(@invalid_attrs)
    end

    test "update_cpu_gpu_miner/2 with valid data updates the cpu_gpu_miner" do
      cpu_gpu_miner = cpu_gpu_miner_fixture()
      update_attrs = %{name: "some updated name", api_code: "some updated api_code", cpu_1_name: "some updated cpu_1_name", cpu_2_name: "some updated cpu_2_name", ram_size: "some updated ram_size", gpu_1_name: "some updated gpu_1_name", gpu_2_name: "some updated gpu_2_name", gpu_3_name: "some updated gpu_3_name", gpu_4_name: "some updated gpu_4_name", gpu_5_name: "some updated gpu_5_name", gpu_6_name: "some updated gpu_6_name", gpu_7_name: "some updated gpu_7_name", gpu_8_name: "some updated gpu_8_name"}

      assert {:ok, %CpuGpuMiner{} = cpu_gpu_miner} = CpuGpuMiners.update_cpu_gpu_miner(cpu_gpu_miner, update_attrs)
      assert cpu_gpu_miner.name == "some updated name"
      assert cpu_gpu_miner.api_code == "some updated api_code"
      assert cpu_gpu_miner.cpu_1_name == "some updated cpu_1_name"
      assert cpu_gpu_miner.cpu_2_name == "some updated cpu_2_name"
      assert cpu_gpu_miner.ram_size == "some updated ram_size"
      assert cpu_gpu_miner.gpu_1_name == "some updated gpu_1_name"
      assert cpu_gpu_miner.gpu_2_name == "some updated gpu_2_name"
      assert cpu_gpu_miner.gpu_3_name == "some updated gpu_3_name"
      assert cpu_gpu_miner.gpu_4_name == "some updated gpu_4_name"
      assert cpu_gpu_miner.gpu_5_name == "some updated gpu_5_name"
      assert cpu_gpu_miner.gpu_6_name == "some updated gpu_6_name"
      assert cpu_gpu_miner.gpu_7_name == "some updated gpu_7_name"
      assert cpu_gpu_miner.gpu_8_name == "some updated gpu_8_name"
    end

    test "update_cpu_gpu_miner/2 with invalid data returns error changeset" do
      cpu_gpu_miner = cpu_gpu_miner_fixture()
      assert {:error, %Ecto.Changeset{}} = CpuGpuMiners.update_cpu_gpu_miner(cpu_gpu_miner, @invalid_attrs)
      assert cpu_gpu_miner == CpuGpuMiners.get_cpu_gpu_miner!(cpu_gpu_miner.id)
    end

    test "delete_cpu_gpu_miner/1 deletes the cpu_gpu_miner" do
      cpu_gpu_miner = cpu_gpu_miner_fixture()
      assert {:ok, %CpuGpuMiner{}} = CpuGpuMiners.delete_cpu_gpu_miner(cpu_gpu_miner)
      assert_raise Ecto.NoResultsError, fn -> CpuGpuMiners.get_cpu_gpu_miner!(cpu_gpu_miner.id) end
    end

    test "change_cpu_gpu_miner/1 returns a cpu_gpu_miner changeset" do
      cpu_gpu_miner = cpu_gpu_miner_fixture()
      assert %Ecto.Changeset{} = CpuGpuMiners.change_cpu_gpu_miner(cpu_gpu_miner)
    end
  end
end
