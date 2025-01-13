defmodule MiningRigMonitor.AsicMinerLogs do
  @moduledoc """
  The AsicMinerLogs context.
  """

  import Ecto.Query, warn: false
  alias MiningRigMonitor.Repo
  alias MiningRigMonitor.AsicMinerLogs.AsicMinerLog

  @doc """
  Creates a asic_miner_log.

  ## Examples

      iex> create_asic_miner_log(%{field: value})
      {:ok, %AsicMinerLog{}}

      iex> create_asic_miner_log(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_asic_miner_log(attrs \\ %{}) do
    %AsicMinerLog{}
    |> AsicMinerLog.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking asic_miner_log changes.

  ## Examples

      iex> change_asic_miner_log(asic_miner_log)
      %Ecto.Changeset{data: %AsicMinerLog{}}

  """
  def change_asic_miner_log(%AsicMinerLog{} = asic_miner_log, attrs \\ %{}) do
    AsicMinerLog.changeset(asic_miner_log, attrs)
  end
end
