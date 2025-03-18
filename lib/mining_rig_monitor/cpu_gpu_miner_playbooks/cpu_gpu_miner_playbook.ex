defmodule MiningRigMonitor.CpuGpuMinerPlaybooks.CpuGpuMinerPlaybook do
  use Ecto.Schema
  import Ecto.Changeset

  schema "cpu_gpu_miner_playbooks" do
    field :cpu_gpu_miner_id, :integer
    field :software_name, :string
    field :software_version, :string
    field :command_argument, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(cpu_gpu_miner_playbook, attrs) do
    cpu_gpu_miner_playbook
    |> cast(attrs, [:cpu_gpu_miner_id, :software_name, :software_version, :command_argument])
    |> validate_required([:cpu_gpu_miner_id, :software_name, :software_version, :command_argument])
  end
end
