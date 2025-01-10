defmodule MiningRigMonitor.AsicMiners do
  @moduledoc """
  The AsicMiners context.
  """

  import Ecto.Query, warn: false
  alias MiningRigMonitor.Repo

  alias MiningRigMonitor.AsicMiners.AsicMiner

  @doc """
  Returns the list of asic_miners.

  ## Examples

      iex> list_asic_miners()
      [%AsicMiner{}, ...]

  """
  def list_asic_miners do
    Repo.all(AsicMiner)
  end

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
  Creates a asic_miner.

  ## Examples

      iex> create_asic_miner(%{field: value})
      {:ok, %AsicMiner{}}

      iex> create_asic_miner(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_asic_miner_by_commander(attrs \\ %{}) do
    api_code = UUID.uuid1()
    attrs_mod = attrs
    |> Map.put("api_code", api_code)
    |> Map.put("activated", false)

    %AsicMiner{}
    |> AsicMiner.changeset_new_by_commander(attrs_mod)
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

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking asic_miner changes.

  ## Examples

      iex> change_asic_miner(asic_miner)
      %Ecto.Changeset{data: %AsicMiner{}}

  """
  def change_asic_miner(%AsicMiner{} = asic_miner, attrs \\ %{}) do
    AsicMiner.changeset(asic_miner, attrs)
  end
end
