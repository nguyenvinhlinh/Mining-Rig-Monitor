defmodule MiningRigMonitorWeb.CpuGpuMinerPlaybookController do
  use MiningRigMonitorWeb, :controller
  require Logger
  alias MiningRigMonitor.CpuGpuMinerPlaybooks
  alias MiningRigMonitor.CpuGpuMinerPlaybooks.CpuGpuMinerPlaybook
  alias MiningRigMonitor.Repo
  action_fallback MiningRigMonitorWeb.FallbackController

  def get_playbook_list(conn, _params) do
    cpu_gpu_miner = conn.assigns.cpu_gpu_miner
    Logger.warning("[CpuGpuMinerPlaybookController] Preload cpu_gpu_miner_playbook_list's addresses will be overload. Should be improved!")
    playbook_list = CpuGpuMinerPlaybooks.list_cpu_gpu_miner_playbooks_by_cpu_gpu_miner_id(cpu_gpu_miner.id)
    |> Repo.preload([:cpu_wallet_address, :gpu_wallet_address_1, :gpu_wallet_address_2,
                   :cpu_pool_address, :gpu_pool_address_1, :gpu_pool_address_2])

    data = Enum.map(playbook_list, fn(playbook) ->
      module = CpuGpuMinerPlaybook.get_software_module_by_name_and_version(playbook.software_name, playbook.software_version)
      command_argument_replaced = CpuGpuMinerPlaybook.get_command_argument_replaced(playbook, [worker_name: cpu_gpu_miner.name])

      address_col_list = [
        :cpu_wallet_address, :gpu_wallet_address_1, :gpu_wallet_address_2,
        :cpu_pool_address, :gpu_pool_address_1, :gpu_pool_address_2
      ]

      [cpu_wallet_address, gpu_wallet_address_1, gpu_wallet_address_2,
       cpu_pool_address, gpu_pool_address_1, gpu_pool_address_2] =
        Enum.map(address_col_list, fn(attr) ->
          if Map.get(playbook, attr) == nil do
            nil
          else
            Map.get(playbook, attr)
            |> Map.get(:address)
          end
        end)

      %{
        id: playbook.id,
        software_name: playbook.software_name,
        software_version: playbook.software_version,
        command_argument: command_argument_replaced,
        module: module,

        cpu_coin_name: playbook.cpu_coin_name,
        cpu_algorithm: playbook.cpu_algorithm,
        cpu_wallet_address: cpu_wallet_address,
        cpu_pool_address: cpu_pool_address,

        gpu_coin_name_1: playbook.gpu_coin_name_1,
        gpu_algorithm_1: playbook.gpu_algorithm_1,
        gpu_wallet_address_1: gpu_wallet_address_1,
        gpu_pool_address_1: gpu_pool_address_1,

        gpu_coin_name_2: playbook.gpu_coin_name_2,
        gpu_algorithm_2: playbook.gpu_algorithm_2,
        gpu_wallet_address_2: gpu_wallet_address_2,
        gpu_pool_address_2: gpu_pool_address_2,

        inserted_at: playbook.inserted_at |> NaiveDateTime.to_iso8601(:extended),
        updated_at:  playbook.updated_at  |> NaiveDateTime.to_iso8601(:extended)
      }
    end)
    json(conn, data)
  end

  def get_playbook_module_binary(conn, %{"playbook_id" => playbook_id}) do
    playbook = CpuGpuMinerPlaybooks.get_cpu_gpu_miner_playbook!(playbook_id)
    module = CpuGpuMinerPlaybook.get_software_module_by_name_and_version(playbook.software_name, playbook.software_version)

    {_module, binary, filename} = :code.get_object_code(module)
    send_download(conn, {:binary, binary}, filename: Path.basename(filename))
  end
end
