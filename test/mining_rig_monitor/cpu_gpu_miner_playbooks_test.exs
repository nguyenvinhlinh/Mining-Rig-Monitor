defmodule MiningRigMonitor.CpuGpuMinerPlaybooksTest do
  use MiningRigMonitor.DataCase

  alias MiningRigMonitor.CpuGpuMinerPlaybooks
  alias MiningRigMonitor.CpuGpuMinerPlaybooks.CpuGpuMinerPlaybook
  import MiningRigMonitor.CpuGpuMinerPlaybooksFixtures

  describe "cpu_gpu_miner_playbooks" do
    setup [:setup_cpu_gpu_miner]

    @valid_attrs %{software_name: "XMRig", software_version: "6.22.2", command_argument: "a sample command argument"}
    @invalid_attrs_1 %{cpu_gpu_miner_id: nil, software_name: nil, software_version: nil, command_argument: nil}
    @invalid_attrs_2 %{software_name: "XMRig", software_version: "6.22.2", command_argument: "a sample command argument", cpu_coin_name: "Monero", cpu_algorithm: nil}
    @invalid_attrs_3 %{software_name: "XMRig", software_version: "6.22.2", command_argument: "a sample command argument", gpu_coin_name_1: "Alpehium", gpu_algorithm_1: nil}
    @invalid_attrs_4 %{software_name: "XMRig", software_version: "6.22.2", command_argument: "a sample command argument", gpu_coin_name_2: "Ergo", gpu_algorithm_2: nil}

    test "get_cpu_gpu_miner_playbook!/1 returns the cpu_gpu_miner_playbook with given id", %{cpu_gpu_miner: cpu_gpu_miner} do
      cpu_gpu_miner_playbook = cpu_gpu_miner_playbook_fixture(%{cpu_gpu_miner_id: cpu_gpu_miner.id})
      assert CpuGpuMinerPlaybooks.get_cpu_gpu_miner_playbook!(cpu_gpu_miner_playbook.id) == cpu_gpu_miner_playbook
    end

    test "create_cpu_gpu_miner_playbook/1 with valid data creates a cpu_gpu_miner_playbook", %{cpu_gpu_miner: cpu_gpu_miner} do
      valid_attrs = @valid_attrs
      |> Map.put(:cpu_gpu_miner_id, cpu_gpu_miner.id)

      assert {:ok, %CpuGpuMinerPlaybook{} = cpu_gpu_miner_playbook} = CpuGpuMinerPlaybooks.create_cpu_gpu_miner_playbook(valid_attrs)
      assert cpu_gpu_miner_playbook.cpu_gpu_miner_id == cpu_gpu_miner.id
      assert cpu_gpu_miner_playbook.software_name == "XMRig"
      assert cpu_gpu_miner_playbook.software_version == "6.22.2"
      assert cpu_gpu_miner_playbook.command_argument == "a sample command argument"
    end

    test "create_cpu_gpu_miner_playbook/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = CpuGpuMinerPlaybooks.create_cpu_gpu_miner_playbook(@invalid_attrs_1)
    end

    test "create_cpu_gpu_miner_playbook/1 with invalid data, missing algorithm cpu, gpu" do
      assert {:error, %Ecto.Changeset{}} = CpuGpuMinerPlaybooks.create_cpu_gpu_miner_playbook(@invalid_attrs_2)
      assert {:error, %Ecto.Changeset{}} = CpuGpuMinerPlaybooks.create_cpu_gpu_miner_playbook(@invalid_attrs_3)
      assert {:error, %Ecto.Changeset{}} = CpuGpuMinerPlaybooks.create_cpu_gpu_miner_playbook(@invalid_attrs_4)
    end

    test "update_cpu_gpu_miner_playbook/2 with modified cpu_gpu_miner_id, should not update", %{cpu_gpu_miner: cpu_gpu_miner} do
      cpu_gpu_miner_playbook = cpu_gpu_miner_playbook_fixture(%{cpu_gpu_miner_id: cpu_gpu_miner.id})
      new_cpu_gpu_miner = MiningRigMonitor.CpuGpuMinersFixtures.cpu_gpu_miner_fixture()
      update_attrs = %{cpu_gpu_miner_id: new_cpu_gpu_miner.id}
      assert {:ok, %CpuGpuMinerPlaybook{} = cpu_gpu_miner_playbook} = CpuGpuMinerPlaybooks.update_cpu_gpu_miner_playbook(cpu_gpu_miner_playbook, update_attrs)
      assert cpu_gpu_miner_playbook.cpu_gpu_miner_id == cpu_gpu_miner.id
    end

    test "update_cpu_gpu_miner_playbook/2 with invalid data returns error changeset", %{cpu_gpu_miner: cpu_gpu_miner} do
      cpu_gpu_miner_playbook = cpu_gpu_miner_playbook_fixture(%{cpu_gpu_miner_id: cpu_gpu_miner.id})
      # missing software name,version, command argument
      assert {:error, %Ecto.Changeset{}} = CpuGpuMinerPlaybooks.update_cpu_gpu_miner_playbook(cpu_gpu_miner_playbook, @invalid_attrs_1)
      assert cpu_gpu_miner_playbook == CpuGpuMinerPlaybooks.get_cpu_gpu_miner_playbook!(cpu_gpu_miner_playbook.id)
      # missing cpu algorithm
      assert {:error, %Ecto.Changeset{}} = CpuGpuMinerPlaybooks.update_cpu_gpu_miner_playbook(cpu_gpu_miner_playbook, @invalid_attrs_2)
      assert cpu_gpu_miner_playbook == CpuGpuMinerPlaybooks.get_cpu_gpu_miner_playbook!(cpu_gpu_miner_playbook.id)
      # missing gpu algorithm 1
      assert {:error, %Ecto.Changeset{}} = CpuGpuMinerPlaybooks.update_cpu_gpu_miner_playbook(cpu_gpu_miner_playbook, @invalid_attrs_3)
      assert cpu_gpu_miner_playbook == CpuGpuMinerPlaybooks.get_cpu_gpu_miner_playbook!(cpu_gpu_miner_playbook.id)
      # missing gpu algorithm 2
      assert {:error, %Ecto.Changeset{}} = CpuGpuMinerPlaybooks.update_cpu_gpu_miner_playbook(cpu_gpu_miner_playbook, @invalid_attrs_4)
      assert cpu_gpu_miner_playbook == CpuGpuMinerPlaybooks.get_cpu_gpu_miner_playbook!(cpu_gpu_miner_playbook.id)
    end

    test "delete_cpu_gpu_miner_playbook/1 deletes the cpu_gpu_miner_playbook", %{cpu_gpu_miner: cpu_gpu_miner} do
      cpu_gpu_miner_playbook = cpu_gpu_miner_playbook_fixture(%{cpu_gpu_miner_id: cpu_gpu_miner.id})
      assert {:ok, %CpuGpuMinerPlaybook{}} = CpuGpuMinerPlaybooks.delete_cpu_gpu_miner_playbook(cpu_gpu_miner_playbook)
      assert_raise Ecto.NoResultsError, fn -> CpuGpuMinerPlaybooks.get_cpu_gpu_miner_playbook!(cpu_gpu_miner_playbook.id) end
    end

    test "change_new_cpu_gpu_miner_playbook/1 returns a cpu_gpu_miner_playbook changeset" do
      assert %Ecto.Changeset{} = CpuGpuMinerPlaybooks.change_new_cpu_gpu_miner_playbook(%CpuGpuMinerPlaybook{})
    end

    test "change_edit_cpu_gpu_miner_playbook/1 returns a cpu_gpu_miner_playbook changeset", %{cpu_gpu_miner: cpu_gpu_miner} do
      cpu_gpu_miner_playbook = cpu_gpu_miner_playbook_fixture(%{cpu_gpu_miner_id: cpu_gpu_miner.id})
      assert %Ecto.Changeset{} = CpuGpuMinerPlaybooks.change_edit_cpu_gpu_miner_playbook(cpu_gpu_miner_playbook)
    end
  end

  defp setup_cpu_gpu_miner(_) do
    cpu_gpu_miner = MiningRigMonitor.CpuGpuMinersFixtures.cpu_gpu_miner_fixture()
    %{cpu_gpu_miner: cpu_gpu_miner}
  end
end
