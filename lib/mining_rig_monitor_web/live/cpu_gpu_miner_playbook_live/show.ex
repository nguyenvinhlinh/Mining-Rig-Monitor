defmodule MiningRigMonitorWeb.CpuGpuMinerPlaybookLive.Show do
  use MiningRigMonitorWeb, :live_view
  require Logger

  alias MiningRigMonitor.CpuGpuMinerPlaybooks
  alias MiningRigMonitor.CpuGpuMinerPlaybooks.CpuGpuMinerPlaybook
  alias MiningRigMonitor.CpuGpuMiners
  alias MiningRigMonitor.Repo

  embed_templates "show_html/*"

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"playbook_id" => id}, _, socket) do
    cpu_gpu_miner_playbook = CpuGpuMinerPlaybooks.get_cpu_gpu_miner_playbook!(id)
    |> Repo.preload([:cpu_wallet_address, :gpu_wallet_address_1, :gpu_wallet_address_2,
                   :cpu_pool_address, :gpu_pool_address_1, :gpu_pool_address_2])
    Logger.warning("[CpuGpuMinerPlaybookLive.Show] Preload cpu_gpu_miner_playbook_list's addresses will be overload. Should be improved!")
    cpu_gpu_miner = CpuGpuMiners.get_cpu_gpu_miner!(cpu_gpu_miner_playbook.cpu_gpu_miner_id)
    socket_mod = socket
    |> assign(:page_title, page_title(socket.assigns.live_action))
    |> assign(:cpu_gpu_miner, cpu_gpu_miner)
    |> assign(:cpu_gpu_miner_playbook, cpu_gpu_miner_playbook)
    |> assign(:command_argument_replaced, CpuGpuMinerPlaybook.get_command_argument_replaced(cpu_gpu_miner_playbook))
    {:noreply, socket_mod}

    end

  defp page_title(:show), do: "Show CPU/GPU miner playbook"
end
