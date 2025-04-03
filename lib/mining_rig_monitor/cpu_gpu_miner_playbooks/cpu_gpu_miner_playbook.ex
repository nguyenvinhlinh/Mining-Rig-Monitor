defmodule MiningRigMonitor.CpuGpuMinerPlaybooks.CpuGpuMinerPlaybook do
  use Ecto.Schema
  import Ecto.Changeset

  schema "cpu_gpu_miner_playbooks" do
    field :cpu_gpu_miner_id, :integer
    field :software_name, :string
    field :software_version, :string
    field :command_argument, :string
    field :coin_name_1, :string
    field :coin_name_2, :string
    field :algorithm_1, :string
    field :algorithm_2, :string
    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(cpu_gpu_miner_playbook, attrs) do
    field_list = [:cpu_gpu_miner_id, :software_name, :software_version,
                  :command_argument, :coin_name_1, :algorithm_1]
    field_list = [:cpu_gpu_miner_id, :software_name, :software_version,
                  :command_argument, :coin_name_1, :algorithm_1]

    cpu_gpu_miner_playbook
    |> cast(attrs, field_list)
    |> validate_required(field_list)
    |> unique_constraint([:cpu_gpu_miner_id, :software_name], error_key: :software_name)
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
