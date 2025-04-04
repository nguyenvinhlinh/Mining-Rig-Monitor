defmodule MiningRigMonitor.CpuGpuMinerPlaybooks.CpuGpuMinerPlaybook do
  use Ecto.Schema
  import Ecto.Changeset

  alias MiningRigMonitor.Addresses.Address

  schema "cpu_gpu_miner_playbooks" do
    field :cpu_gpu_miner_id, :integer
    field :software_name, :string
    field :software_version, :string
    field :command_argument, :string
    field :coin_name_1, :string
    field :coin_name_2, :string
    field :algorithm_1, :string
    field :algorithm_2, :string

    belongs_to(:cpu_wallet_address,   Address, foreign_key: :cpu_wallet_address_id)
    belongs_to(:gpu_wallet_address_1, Address, foreign_key: :gpu_wallet_address_1_id)
    belongs_to(:gpu_wallet_address_2, Address, foreign_key: :gpu_wallet_address_2_id)

    belongs_to(:cpu_pool_address,   Address, foreign_key: :cpu_pool_address_id)
    belongs_to(:gpu_pool_address_1, Address, foreign_key: :gpu_pool_address_1_id)
    belongs_to(:gpu_pool_address_2, Address, foreign_key: :gpu_pool_address_2_id)

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(cpu_gpu_miner_playbook, attrs) do
    field_list = [:cpu_gpu_miner_id, :software_name, :software_version,
                  :command_argument, :coin_name_1, :algorithm_1,
                  :coin_name_2, :algorithm_2]
    required_field_list = [:cpu_gpu_miner_id, :software_name, :software_version,
                  :command_argument, :coin_name_1, :algorithm_1]

    cpu_gpu_miner_playbook
    |> cast(attrs, field_list)
    |> validate_required(required_field_list)
    |> unique_constraint([:cpu_gpu_miner_id, :software_name], error_key: :software_name)
  end

  def get_command_argument_replaced(%__MODULE__{}=playbook, args \\ []) do
    command_argument = if playbook.command_argument == nil, do: "", else: playbook.command_argument

    worker_name = Keyword.get(args, :worker_name, "worker")

    cpu_wallet_address =   if playbook.cpu_wallet_address_id,   do: playbook.cpu_wallet_address.address ,  else: ""
    gpu_wallet_address_1 = if playbook.gpu_wallet_address_1_id, do: playbook.gpu_wallet_address_1.address, else: ""
    gpu_wallet_address_2 = if playbook.gpu_wallet_address_2_id, do: playbook.gpu_wallet_address_2.address, else: ""

    cpu_pool_address =   if playbook.cpu_pool_address_id,   do: playbook.cpu_pool_address.address ,  else: ""
    gpu_pool_address_1 = if playbook.gpu_pool_address_1_id, do: playbook.gpu_pool_address_1.address, else: ""
    gpu_pool_address_2 = if playbook.gpu_pool_address_2_id, do: playbook.gpu_pool_address_2.address, else: ""

    replacement_list = [
      {"$WORKER_NAME",  worker_name},
      {"$CPU_WALLET",   cpu_wallet_address},
      {"$GPU_WALLET_1", gpu_wallet_address_1},
      {"$GPU_WALLET_2", gpu_wallet_address_2},
      {"$CPU_POOL",     cpu_pool_address},
      {"$GPU_POOL_1",   gpu_pool_address_1},
      {"$GPU_POOL_2",   gpu_pool_address_2}
    ]

    Enum.reduce(replacement_list, command_argument, fn({e_key, e_value}, acc) ->
      String.replace(acc, e_key, e_value)
    end)
  end

  def get_software_name_list() do
    ["XMRig", "BZMiner"]
  end

  def get_software_version_list_by_name("XMRig") do
    ["6.22.2"]
  end

  def get_software_version_list_by_name("BZMiner") do
    ["23.0.2"]
  end

  def get_software_module_by_name_and_version("XMRig", version) do
    case version do
      "6.22.2" -> "Elixir.MinerProvision.XMRIG_6_22_2"
      _latest ->  "Elixir.MinerProvision.XMRIG_6_22_2"
    end
  end
end
