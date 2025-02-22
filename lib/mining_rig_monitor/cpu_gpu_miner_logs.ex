defmodule MiningRigMonitor.CpuGpuMinerLogs do
  @moduledoc """
  The CpuGpuMinerLogs context.
  """

  import Ecto.Query, warn: false
  alias MiningRigMonitor.Repo

  alias MiningRigMonitor.CpuGpuMinerLogs.CpuGpuMinerLog

  @doc """
  Gets a single cpu_gpu_miner_log.

  Raises `Ecto.NoResultsError` if the Cpu gpu miner log does not exist.

  ## Examples

      iex> get_cpu_gpu_miner_log!(123)
      %CpuGpuMinerLog{}

      iex> get_cpu_gpu_miner_log!(456)
      ** (Ecto.NoResultsError)

  """
  def get_cpu_gpu_miner_log!(id), do: Repo.get!(CpuGpuMinerLog, id)

  @doc """
  Creates a cpu_gpu_miner_log.

  ## Examples

      iex> create_cpu_gpu_miner_log(%{field: value})
      {:ok, %CpuGpuMinerLog{}}

      iex> create_cpu_gpu_miner_log(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_cpu_gpu_miner_log(attrs \\ %{}) do
    %CpuGpuMinerLog{}
    |> CpuGpuMinerLog.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking cpu_gpu_miner_log changes.

  ## Examples

      iex> change_cpu_gpu_miner_log(cpu_gpu_miner_log)
      %Ecto.Changeset{data: %CpuGpuMinerLog{}}

  """
  def change_cpu_gpu_miner_log(%CpuGpuMinerLog{} = cpu_gpu_miner_log, attrs \\ %{}) do
    CpuGpuMinerLog.changeset(cpu_gpu_miner_log, attrs)
  end
end
