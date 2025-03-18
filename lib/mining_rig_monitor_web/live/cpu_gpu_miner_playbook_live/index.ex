defmodule MiningRigMonitorWeb.CpuGpuMinerPlaybookLive.Index do
  use MiningRigMonitorWeb, :live_view

  alias MiningRigMonitor.CpuGpuMinerPlaybooks
  alias MiningRigMonitor.CpuGpuMinerPlaybooks.CpuGpuMinerPlaybook

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :cpu_gpu_miner_playbooks, CpuGpuMinerPlaybooks.list_cpu_gpu_miner_playbooks())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Cpu gpu miner playbook")
    |> assign(:cpu_gpu_miner_playbook, CpuGpuMinerPlaybooks.get_cpu_gpu_miner_playbook!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Cpu gpu miner playbook")
    |> assign(:cpu_gpu_miner_playbook, %CpuGpuMinerPlaybook{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Cpu gpu miner playbooks")
    |> assign(:cpu_gpu_miner_playbook, nil)
  end

  @impl true
  def handle_info({MiningRigMonitorWeb.CpuGpuMinerPlaybookLive.FormComponent, {:saved, cpu_gpu_miner_playbook}}, socket) do
    {:noreply, stream_insert(socket, :cpu_gpu_miner_playbooks, cpu_gpu_miner_playbook)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    cpu_gpu_miner_playbook = CpuGpuMinerPlaybooks.get_cpu_gpu_miner_playbook!(id)
    {:ok, _} = CpuGpuMinerPlaybooks.delete_cpu_gpu_miner_playbook(cpu_gpu_miner_playbook)

    {:noreply, stream_delete(socket, :cpu_gpu_miner_playbooks, cpu_gpu_miner_playbook)}
  end
end
