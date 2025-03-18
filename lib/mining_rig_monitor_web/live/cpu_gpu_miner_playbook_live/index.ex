defmodule MiningRigMonitorWeb.CpuGpuMinerPlaybookLive.Index do
  use MiningRigMonitorWeb, :live_view
  alias MiningRigMonitor.CpuGpuMiners
  alias MiningRigMonitor.CpuGpuMinerPlaybooks
  alias MiningRigMonitor.CpuGpuMinerPlaybooks.CpuGpuMinerPlaybook

  embed_templates "index_html/*"

  @impl true
  def mount(%{"cpu_gpu_miner_id" => cpu_gpu_miner_id}, _session, socket) do
    cpu_gpu_miner = CpuGpuMiners.get_cpu_gpu_miner(cpu_gpu_miner_id)
    cpu_gpu_miner_playbook_list =  CpuGpuMinerPlaybooks.list_cpu_gpu_miner_playbooks_by_cpu_gpu_miner_id(cpu_gpu_miner_id)

    socket_mod = socket
    |> stream(:cpu_gpu_miner_playbook_list, cpu_gpu_miner_playbook_list)
    |> assign(:cpu_gpu_miner, cpu_gpu_miner)

    {:ok, socket_mod}
  end

  # @impl true
  # def mount(_params, _session, socket) do
  #   {:ok, stream(socket, :cpu_gpu_miner_playbooks, CpuGpuMinerPlaybooks.list_cpu_gpu_miner_playbooks())}
  # end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"playbook_id" => playbook_id}) do
    socket
    |> assign(:page_title, "Edit CPU/GPU miner playbook")
    |> assign(:cpu_gpu_miner_playbook, CpuGpuMinerPlaybooks.get_cpu_gpu_miner_playbook!(playbook_id))
  end

  defp apply_action(socket, :new, %{"cpu_gpu_miner_id"=> cpu_gpu_miner_id}=params) do
    socket
    |> assign(:page_title, "New CPU/GPU miner playbook")
    |> assign(:cpu_gpu_miner_playbook, %CpuGpuMinerPlaybook{cpu_gpu_miner_id: cpu_gpu_miner_id})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing CPU/GPU miner playbooks")
    |> assign(:cpu_gpu_miner_playbook, nil)
  end

  @impl true
  def handle_info({MiningRigMonitorWeb.CpuGpuMinerPlaybookLive.FormComponent, {:saved, cpu_gpu_miner_playbook}}, socket) do
    {:noreply, stream_insert(socket, :cpu_gpu_miner_playbook_list, cpu_gpu_miner_playbook)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    cpu_gpu_miner_playbook = CpuGpuMinerPlaybooks.get_cpu_gpu_miner_playbook!(id)
    {:ok, _} = CpuGpuMinerPlaybooks.delete_cpu_gpu_miner_playbook(cpu_gpu_miner_playbook)

    {:noreply, stream_delete(socket, :cpu_gpu_miner_playbooks, cpu_gpu_miner_playbook)}
  end
end
