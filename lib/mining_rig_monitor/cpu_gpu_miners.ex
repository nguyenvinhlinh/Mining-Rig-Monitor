defmodule MiningRigMonitor.CpuGpuMiners do
  @moduledoc """
  The CpuGpuMiners context.
  """

  import Ecto.Query, warn: false
  alias MiningRigMonitor.Repo

  alias MiningRigMonitor.CpuGpuMiners.CpuGpuMiner

  @doc """
  Returns the list of cpu_gpu_miners.

  ## Examples

      iex> list_cpu_gpu_miners()
      [%CpuGpuMiner{}, ...]

  """
  def list_cpu_gpu_miners do
    Repo.all(CpuGpuMiner)
  end

  def list_cpu_gpu_miners_by_activated_state(activated_state) when is_boolean(activated_state)  do
    CpuGpuMiner
    |> where(activated: ^activated_state)
    |> Repo.all()
  end

  @doc """
  Gets a single cpu_gpu_miner.

  Raises `Ecto.NoResultsError` if the Cpu gpu miner does not exist.

  ## Examples

      iex> get_cpu_gpu_miner!(123)
      %CpuGpuMiner{}

      iex> get_cpu_gpu_miner!(456)
      ** (Ecto.NoResultsError)

  """
  def get_cpu_gpu_miner!(id), do: Repo.get!(CpuGpuMiner, id)

  def get_cpu_gpu_miner(id), do: Repo.get(CpuGpuMiner, id)

  def create_cpu_gpu_miner_by_commander(attrs \\ %{}) do
    api_code = UUID.uuid1()
    attrs_mod = attrs
    |> Map.put("api_code", api_code)
    |> Map.put("activated", false)

    %CpuGpuMiner{}
    |> CpuGpuMiner.changeset_new_by_commander(attrs_mod)
    |> Repo.insert()
  end

  @doc """
  Creates a cpu_gpu_miner.

  ## Examples

      iex> create_cpu_gpu_miner(%{field: value})
      {:ok, %CpuGpuMiner{}}

      iex> create_cpu_gpu_miner(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_cpu_gpu_miner(attrs \\ %{}) do
    %CpuGpuMiner{}
    |> CpuGpuMiner.changeset(attrs)
    |> Repo.insert()
  end

  def update_cpu_gpu_miner_by_commander(%CpuGpuMiner{} = cpu_gpu_miner, attrs) do
    cpu_gpu_miner
    |> CpuGpuMiner.changeset_edit_by_commander(attrs)
    |> Repo.update()
  end

  def update_cpu_gpu_miner_by_sentry(%CpuGpuMiner{} = cpu_gpu_miner, attrs) do
    cpu_gpu_miner
    |> CpuGpuMiner.changeset_edit_by_sentry(attrs)
    |> Repo.update()
  end

  @doc """
  Updates a cpu_gpu_miner.

  ## Examples

      iex> update_cpu_gpu_miner(cpu_gpu_miner, %{field: new_value})
      {:ok, %CpuGpuMiner{}}

      iex> update_cpu_gpu_miner(cpu_gpu_miner, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_cpu_gpu_miner(%CpuGpuMiner{} = cpu_gpu_miner, attrs) do
    cpu_gpu_miner
    |> CpuGpuMiner.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a cpu_gpu_miner.

  ## Examples

      iex> delete_cpu_gpu_miner(cpu_gpu_miner)
      {:ok, %CpuGpuMiner{}}

      iex> delete_cpu_gpu_miner(cpu_gpu_miner)
      {:error, %Ecto.Changeset{}}

  """
  def delete_cpu_gpu_miner(%CpuGpuMiner{} = cpu_gpu_miner) do
    Repo.delete(cpu_gpu_miner)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking cpu_gpu_miner changes.

  ## Examples

      iex> change_cpu_gpu_miner(cpu_gpu_miner)
      %Ecto.Changeset{data: %CpuGpuMiner{}}

  """
  def change_cpu_gpu_miner(%CpuGpuMiner{} = cpu_gpu_miner, attrs \\ %{}) do
    CpuGpuMiner.changeset(cpu_gpu_miner, attrs)
  end

  def change_cpu_gpu_miner_by_commander(%CpuGpuMiner{} = cpu_gpu_miner, attrs \\ %{}) do
    CpuGpuMiner.changeset_edit_by_commander(cpu_gpu_miner, attrs)
  end

  def get_cpu_gpu_miner_by_api_code(code) do
    Repo.get_by(CpuGpuMiner, api_code: code)
  end
end
