defmodule MiningRigMonitorWeb.CpuGpuMinerPlaybookLive.Index do
  use MiningRigMonitorWeb, :live_view_container_grow
  require Logger
  alias MiningRigMonitor.CpuGpuMiners
  alias MiningRigMonitor.CpuGpuMinerPlaybooks
  alias MiningRigMonitor.Repo

  on_mount MiningRigMonitorWeb.UserAuthLive
  embed_templates "index_html/*"

  @impl true
  def mount(%{"cpu_gpu_miner_id" => cpu_gpu_miner_id}, _session, socket) do
    cpu_gpu_miner = CpuGpuMiners.get_cpu_gpu_miner(cpu_gpu_miner_id)
    Logger.warning("[CpuGpuMinerPlaybookLive.Index] Preload cpu_gpu_miner_playbook_list's addresses will be overload. Should be improved!")
    cpu_gpu_miner_playbook_list =  CpuGpuMinerPlaybooks.list_cpu_gpu_miner_playbooks_by_cpu_gpu_miner_id(cpu_gpu_miner_id)
    |> Repo.preload([:cpu_wallet_address, :gpu_wallet_address_1, :gpu_wallet_address_2,
                   :cpu_pool_address, :gpu_pool_address_1, :gpu_pool_address_2])
    socket_mod = socket
    |> stream(:cpu_gpu_miner_playbook_list, cpu_gpu_miner_playbook_list)
    |> assign(:cpu_gpu_miner, cpu_gpu_miner)
    |> assign(:page_title, "Listing CPU/GPU miner playbooks")
    |> assign(:cpu_gpu_miner_playbook, nil)
    {:ok, socket_mod}
  end

  @impl true
  def handle_info({MiningRigMonitorWeb.CpuGpuMinerPlaybookLive.FormComponent, {:saved, cpu_gpu_miner_playbook}}, socket) do
    cpu_gpu_miner_playbook_mod = cpu_gpu_miner_playbook
    |> Repo.preload([:cpu_wallet_address, :gpu_wallet_address_1, :gpu_wallet_address_2,
                   :cpu_pool_address, :gpu_pool_address_1, :gpu_pool_address_2])
    {:noreply, stream_insert(socket, :cpu_gpu_miner_playbook_list, cpu_gpu_miner_playbook_mod)}
  end

  @impl true
  def handle_event("delete", %{"playbook_id" => id}, socket) do
    miner_playbook = CpuGpuMinerPlaybooks.get_cpu_gpu_miner_playbook!(id)
    {:ok, _} = CpuGpuMinerPlaybooks.delete_cpu_gpu_miner_playbook(miner_playbook)

    socket_mod = socket
    |> stream_delete(:cpu_gpu_miner_playbook_list, miner_playbook)
    |> put_flash(:info, "Playbook #{miner_playbook.software_name} #{miner_playbook.software_version} deleted")

    {:noreply, socket_mod}
  end
end
