defmodule MiningRigMonitorWeb.CpuGpuMinerPlaybookLive.Show do
  use MiningRigMonitorWeb, :live_view
  require Logger

  alias MiningRigMonitor.CpuGpuMinerPlaybooks
  alias MiningRigMonitor.CpuGpuMinerPlaybooks.CpuGpuMinerPlaybook
  alias MiningRigMonitor.CpuGpuMiners
  alias MiningRigMonitor.Repo

  embed_templates "show_html/*"

  @impl true
  def mount(%{"playbook_id" => id}, _session, socket) do
    cpu_gpu_miner_playbook = CpuGpuMinerPlaybooks.get_cpu_gpu_miner_playbook!(id)
    |> Repo.preload([:cpu_wallet_address, :gpu_wallet_address_1, :gpu_wallet_address_2,
                   :cpu_pool_address, :gpu_pool_address_1, :gpu_pool_address_2])
    Logger.warning("[CpuGpuMinerPlaybookLive.Show] Prel oad cpu_gpu_miner_playbook_list's addresses will be overload. Should be improved!")
    cpu_gpu_miner = CpuGpuMiners.get_cpu_gpu_miner!(cpu_gpu_miner_playbook.cpu_gpu_miner_id)
    command_argument_replaced = CpuGpuMinerPlaybook.get_command_argument_replaced(cpu_gpu_miner_playbook, [worker_name: cpu_gpu_miner.name])

    socket_mod = socket
    |> assign(:page_title, page_title(socket.assigns.live_action))
    |> assign(:cpu_gpu_miner, cpu_gpu_miner)
    |> assign(:cpu_gpu_miner_playbook, cpu_gpu_miner_playbook)
    |> assign(:command_argument_replaced, command_argument_replaced)


    {:ok, socket_mod}
  end

  @impl true
  def handle_params(%{"playbook_id" => id}=params, _, socket) do
    socket_mod = socket
    |> assign(:page_title, page_title(socket.assigns.live_action))
    {:noreply, socket_mod}
  end

  @impl true
  def handle_info({MiningRigMonitorWeb.CpuGpuMinerPlaybookLive.FormComponent, {:saved, cpu_gpu_miner_playbook}}, socket) do
    Logger.warning("[CpuGpuMinerPlaybookLive.Show] handle_info {:saved} Preload cpu_gpu_miner_playbook_list's addresses will be overload. Should be improved!")
    cpu_gpu_miner_playbook_mod = cpu_gpu_miner_playbook
    |> Repo.preload([:cpu_wallet_address, :gpu_wallet_address_1, :gpu_wallet_address_2,
                   :cpu_pool_address, :gpu_pool_address_1, :gpu_pool_address_2], [force: true])
    cpu_gpu_miner = CpuGpuMiners.get_cpu_gpu_miner!(cpu_gpu_miner_playbook.cpu_gpu_miner_id)
    command_argument_replaced = CpuGpuMinerPlaybook.get_command_argument_replaced(cpu_gpu_miner_playbook_mod, [worker_name: cpu_gpu_miner.name])

    socket_mod = socket
    |> assign(:page_title, page_title(socket.assigns.live_action))
    |> assign(:cpu_gpu_miner, cpu_gpu_miner)
    |> assign(:cpu_gpu_miner_playbook, cpu_gpu_miner_playbook_mod)
    |> assign(:command_argument_replaced, command_argument_replaced)

    {:noreply, socket_mod}
  end

  defp page_title(:show), do: "Show CPU/GPU miner playbook"
  defp page_title(:edit), do: "Edit CPU/GPU miner playbook"
end
