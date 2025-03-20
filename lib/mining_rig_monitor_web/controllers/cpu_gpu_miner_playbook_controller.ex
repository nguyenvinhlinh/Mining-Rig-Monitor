defmodule MiningRigMonitorWeb.CpuGpuMinerPlaybookController do
  use MiningRigMonitorWeb, :controller
  alias MiningRigMonitor.CpuGpuMinerPlaybooks
  alias MiningRigMonitor.CpuGpuMinerPlaybooks.CpuGpuMinerPlaybook

  action_fallback MiningRigMonitorWeb.FallbackController

  def get_playbook_list(conn, _params) do
    cpu_gpu_miner = conn.assigns.cpu_gpu_miner
    playbook_list = CpuGpuMinerPlaybooks.list_cpu_gpu_miner_playbooks_by_cpu_gpu_miner_id(cpu_gpu_miner.id)

    data = Enum.map(playbook_list, fn(e) ->
      module = CpuGpuMinerPlaybook.get_software_module_by_name_and_version(e.software_name, e.software_version)
      %{
        id: e.id,
        software_name: e.software_name,
        software_version: e.software_version,
        command_argument: e.command_argument,
        module: module,
        coin_name_1: "XXX",
        coin_name_2: nil}
    end)
    json(conn, data)
  end
end
