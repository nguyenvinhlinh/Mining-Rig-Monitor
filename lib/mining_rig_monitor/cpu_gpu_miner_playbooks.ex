defmodule MiningRigMonitor.CpuGpuMinerPlaybooks do
  @moduledoc """
  The CpuGpuMinerPlaybooks context.
  """

  import Ecto.Query, warn: false
  alias MiningRigMonitor.Repo

  alias MiningRigMonitor.CpuGpuMinerPlaybooks.CpuGpuMinerPlaybook

  @doc """
  Returns the list of cpu_gpu_miner_playbooks.

  ## Examples

      iex> list_cpu_gpu_miner_playbooks()
      [%CpuGpuMinerPlaybook{}, ...]

  """
  def list_cpu_gpu_miner_playbooks do
    Repo.all(CpuGpuMinerPlaybook)
  end

  def list_cpu_gpu_miner_playbooks_by_cpu_gpu_miner_id(id) do
    query = CpuGpuMinerPlaybook
    |> where([cgmp], cgmp.cpu_gpu_miner_id == ^id )
    |> order_by([cgmp], asc: cgmp.id)
    Repo.all(query)
  end

  @doc """
  Gets a single cpu_gpu_miner_playbook.

  Raises `Ecto.NoResultsError` if the Cpu gpu miner playbook does not exist.

  ## Examples

      iex> get_cpu_gpu_miner_playbook!(123)
      %CpuGpuMinerPlaybook{}

      iex> get_cpu_gpu_miner_playbook!(456)
      ** (Ecto.NoResultsError)

  """
  def get_cpu_gpu_miner_playbook!(id), do: Repo.get!(CpuGpuMinerPlaybook, id)

  @doc """
  Creates a cpu_gpu_miner_playbook.

  ## Examples

      iex> create_cpu_gpu_miner_playbook(%{field: value})
      {:ok, %CpuGpuMinerPlaybook{}}

      iex> create_cpu_gpu_miner_playbook(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_cpu_gpu_miner_playbook(attrs \\ %{}) do
    %CpuGpuMinerPlaybook{}
    |> CpuGpuMinerPlaybook.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a cpu_gpu_miner_playbook.

  ## Examples

      iex> update_cpu_gpu_miner_playbook(cpu_gpu_miner_playbook, %{field: new_value})
      {:ok, %CpuGpuMinerPlaybook{}}

      iex> update_cpu_gpu_miner_playbook(cpu_gpu_miner_playbook, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_cpu_gpu_miner_playbook(%CpuGpuMinerPlaybook{} = cpu_gpu_miner_playbook, attrs) do
    cpu_gpu_miner_playbook
    |> CpuGpuMinerPlaybook.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a cpu_gpu_miner_playbook.

  ## Examples

      iex> delete_cpu_gpu_miner_playbook(cpu_gpu_miner_playbook)
      {:ok, %CpuGpuMinerPlaybook{}}

      iex> delete_cpu_gpu_miner_playbook(cpu_gpu_miner_playbook)
      {:error, %Ecto.Changeset{}}

  """
  def delete_cpu_gpu_miner_playbook(%CpuGpuMinerPlaybook{} = cpu_gpu_miner_playbook) do
    Repo.delete(cpu_gpu_miner_playbook)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking cpu_gpu_miner_playbook changes.

  ## Examples

      iex> change_cpu_gpu_miner_playbook(cpu_gpu_miner_playbook)
      %Ecto.Changeset{data: %CpuGpuMinerPlaybook{}}

  """
  def change_cpu_gpu_miner_playbook(%CpuGpuMinerPlaybook{} = cpu_gpu_miner_playbook, attrs \\ %{}) do
    CpuGpuMinerPlaybook.changeset(cpu_gpu_miner_playbook, attrs)
  end
end
