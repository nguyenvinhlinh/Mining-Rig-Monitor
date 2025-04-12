defmodule MiningRigMonitor.CpuGpuMinerPlaybooksTest do
  use MiningRigMonitor.DataCase

  alias MiningRigMonitor.CpuGpuMinerPlaybooks

  describe "cpu_gpu_miner_playbooks" do
    alias MiningRigMonitor.CpuGpuMinerPlaybooks.CpuGpuMinerPlaybook

    import MiningRigMonitor.CpuGpuMinerPlaybooksFixtures

    @invalid_attrs %{cpu_gpu_miner_id: nil, software_name: nil, software_version: nil, command_argument: nil}

    test "list_cpu_gpu_miner_playbooks/0 returns all cpu_gpu_miner_playbooks" do
      cpu_gpu_miner_playbook = cpu_gpu_miner_playbook_fixture()
      assert CpuGpuMinerPlaybooks.list_cpu_gpu_miner_playbooks() == [cpu_gpu_miner_playbook]
    end

    test "get_cpu_gpu_miner_playbook!/1 returns the cpu_gpu_miner_playbook with given id" do
      cpu_gpu_miner_playbook = cpu_gpu_miner_playbook_fixture()
      assert CpuGpuMinerPlaybooks.get_cpu_gpu_miner_playbook!(cpu_gpu_miner_playbook.id) == cpu_gpu_miner_playbook
    end

    test "create_cpu_gpu_miner_playbook/1 with valid data creates a cpu_gpu_miner_playbook" do
      valid_attrs = %{cpu_gpu_miner_id: 42, software_name: "some software_name", software_version: "some software_version", command_argument: "some command_argument"}

      assert {:ok, %CpuGpuMinerPlaybook{} = cpu_gpu_miner_playbook} = CpuGpuMinerPlaybooks.create_cpu_gpu_miner_playbook(valid_attrs)
      assert cpu_gpu_miner_playbook.cpu_gpu_miner_id == 42
      assert cpu_gpu_miner_playbook.software_name == "some software_name"
      assert cpu_gpu_miner_playbook.software_version == "some software_version"
      assert cpu_gpu_miner_playbook.command_argument == "some command_argument"
    end

    test "create_cpu_gpu_miner_playbook/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = CpuGpuMinerPlaybooks.create_cpu_gpu_miner_playbook(@invalid_attrs)
    end

    test "update_cpu_gpu_miner_playbook/2 with valid data updates the cpu_gpu_miner_playbook" do
      cpu_gpu_miner_playbook = cpu_gpu_miner_playbook_fixture()
      update_attrs = %{cpu_gpu_miner_id: 43, software_name: "some updated software_name", software_version: "some updated software_version", command_argument: "some updated command_argument"}

      assert {:ok, %CpuGpuMinerPlaybook{} = cpu_gpu_miner_playbook} = CpuGpuMinerPlaybooks.update_cpu_gpu_miner_playbook(cpu_gpu_miner_playbook, update_attrs)
      assert cpu_gpu_miner_playbook.cpu_gpu_miner_id == 43
      assert cpu_gpu_miner_playbook.software_name == "some updated software_name"
      assert cpu_gpu_miner_playbook.software_version == "some updated software_version"
      assert cpu_gpu_miner_playbook.command_argument == "some updated command_argument"
    end

    test "update_cpu_gpu_miner_playbook/2 with invalid data returns error changeset" do
      cpu_gpu_miner_playbook = cpu_gpu_miner_playbook_fixture()
      assert {:error, %Ecto.Changeset{}} = CpuGpuMinerPlaybooks.update_cpu_gpu_miner_playbook(cpu_gpu_miner_playbook, @invalid_attrs)
      assert cpu_gpu_miner_playbook == CpuGpuMinerPlaybooks.get_cpu_gpu_miner_playbook!(cpu_gpu_miner_playbook.id)
    end

    test "delete_cpu_gpu_miner_playbook/1 deletes the cpu_gpu_miner_playbook" do
      cpu_gpu_miner_playbook = cpu_gpu_miner_playbook_fixture()
      assert {:ok, %CpuGpuMinerPlaybook{}} = CpuGpuMinerPlaybooks.delete_cpu_gpu_miner_playbook(cpu_gpu_miner_playbook)
      assert_raise Ecto.NoResultsError, fn -> CpuGpuMinerPlaybooks.get_cpu_gpu_miner_playbook!(cpu_gpu_miner_playbook.id) end
    end

    test "change_cpu_gpu_miner_playbook/1 returns a cpu_gpu_miner_playbook changeset" do
      cpu_gpu_miner_playbook = cpu_gpu_miner_playbook_fixture()
      assert %Ecto.Changeset{} = CpuGpuMinerPlaybooks.change_cpu_gpu_miner_playbook(cpu_gpu_miner_playbook)
    end
  end
end
