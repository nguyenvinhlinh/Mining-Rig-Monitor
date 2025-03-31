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
      Kernel.to_string |> String.replace("Elixir.", "")
      module_mod = module
      |> Kernel.to_string
      |> String.replace("Elixir.", "")

      %{
        id: e.id,
        software_name: e.software_name,
        software_version: e.software_version,
        command_argument: e.command_argument,
        module: module_mod,
        coin_name_1: e.coin_name_1,
        algorithm_1: e.algorithm_1,
        coin_name_2: e.coin_name_2,
        algorithm_2: e.algorithm_2
      }
    end)
    json(conn, data)
  end

  def get_playbook_module_binary(conn, %{"playbook_id" => playbook_id}=params) do
    playbook = CpuGpuMinerPlaybooks.get_cpu_gpu_miner_playbook!(playbook_id)
    module = CpuGpuMinerPlaybook.get_software_module_by_name_and_version(playbook.software_name, playbook.software_version)

    {_module, binary, filename} = :code.get_object_code(module)
    send_download(conn, {:binary, binary}, filename: Path.basename(filename))
  end
end
