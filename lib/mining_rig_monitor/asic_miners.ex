defmodule MiningRigMonitor.AsicMiners do
  @moduledoc """
  The AsicMiners context.
  """

  import Ecto.Query, warn: false
  require Logger
  alias MiningRigMonitor.Repo
  alias MiningRigMonitor.AsicMiners.AsicMiner

  @doc """
  Returns the list of asic_miners by given activated_state (true/false).

  ## Examples

      iex> list_asic_miners_by_activated_state
      [%AsicMiner{}, ...]

  """

  def list_asic_miners_by_activated_state(activated_state) when is_boolean(activated_state)  do
    AsicMiner
    |> where(activated: ^activated_state)
    |> Repo.all()
  end

  @doc """
  Gets a single asic_miner.

  Raises `Ecto.NoResultsError` if the Asic miner does not exist.

  ## Examples

      iex> get_asic_miner!(123)
      %AsicMiner{}

      iex> get_asic_miner!(456)
      ** (Ecto.NoResultsError)

  """
  def get_asic_miner!(id), do: Repo.get!(AsicMiner, id)

  @doc """
  Creates a asic_miner by commander (this software is the commander). I can only
  create an empty asic miner. Updating asic miner spec is a sentry responsibility!

  ## Examples

      iex> create_asic_miner_by_commander(%{field: value})
      {:ok, %AsicMiner{}}

      iex> create_asic_miner_by_commander(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """

  def create_asic_miner_by_commander(attrs \\ %{}) do
    %AsicMiner{}
    |> AsicMiner.changeset_new_by_commander(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a asic_miner.

  ## Examples

      iex> update_asic_miner(asic_miner, %{field: new_value})
      {:ok, %AsicMiner{}}

      iex> update_asic_miner(asic_miner, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_asic_miner_by_commander(%AsicMiner{} = asic_miner, attrs) do
    asic_miner
    |> AsicMiner.changeset_edit_by_commander(attrs)
    |> Repo.update()
  end

  def update_asic_miner_by_sentry(%AsicMiner{} = asic_miner, attrs) do
    Logger.warning("[#{__MODULE__}] update_asic_miner_by_sentry/1 needs unit test")
    asic_miner
    |> AsicMiner.changeset_edit_by_sentry(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a asic_miner.

  ## Examples

      iex> delete_asic_miner(asic_miner)
      {:ok, %AsicMiner{}}

      iex> delete_asic_miner(asic_miner)
      {:error, %Ecto.Changeset{}}

  """
  def delete_asic_miner(%AsicMiner{} = asic_miner) do
    Repo.delete(asic_miner)
  end

  def get_asic_miner_by_api_code(code) do
    Logger.warning("[#{__MODULE__}] get_asic_miner_by_api_code/1 needs unit test")
    Repo.get_by(AsicMiner, api_code: code)
  end

  def get_asic_miner_by_api_code_list(api_code_list) when is_list(api_code_list) do
    query = from am in AsicMiner, where: am.api_code in ^api_code_list
    Repo.all(query)
  end
end
