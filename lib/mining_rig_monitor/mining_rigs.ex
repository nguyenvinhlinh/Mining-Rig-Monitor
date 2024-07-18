defmodule MiningRigMonitor.MiningRigs do
  @moduledoc """
  The MiningRigs context.
  """

  import Ecto.Query, warn: false
  alias MiningRigMonitor.Repo

  alias MiningRigMonitor.MiningRigs.MiningRig

  @doc """
  Returns the list of mining_rigs.

  ## Examples

      iex> list_mining_rigs()
      [%MiningRig{}, ...]

  """
  def list_mining_rigs do
    Repo.all(MiningRig)
  end

  @doc """
  Gets a single mining_rig.

  Raises `Ecto.NoResultsError` if the Mining rig does not exist.

  ## Examples

      iex> get_mining_rig!(123)
      %MiningRig{}

      iex> get_mining_rig!(456)
      ** (Ecto.NoResultsError)

  """
  def get_mining_rig!(id), do: Repo.get!(MiningRig, id)

  @doc """
  Creates a mining_rig.

  ## Examples

      iex> create_mining_rig(%{field: value})
      {:ok, %MiningRig{}}

      iex> create_mining_rig(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_mining_rig(attrs \\ %{}) do
    %MiningRig{}
    |> MiningRig.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a mining_rig.

  ## Examples

      iex> update_mining_rig(mining_rig, %{field: new_value})
      {:ok, %MiningRig{}}

      iex> update_mining_rig(mining_rig, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_mining_rig(%MiningRig{} = mining_rig, attrs) do
    mining_rig
    |> MiningRig.changeset(attrs)
    |> Repo.update()
  end

  def update_asic_mining_rig(%MiningRig{} = mining_rig, attrs) do
    mining_rig
    |> MiningRig.changeset_asic(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a mining_rig.

  ## Examples

      iex> delete_mining_rig(mining_rig)
      {:ok, %MiningRig{}}

      iex> delete_mining_rig(mining_rig)
      {:error, %Ecto.Changeset{}}

  """
  def delete_mining_rig(%MiningRig{} = mining_rig) do
    Repo.delete(mining_rig)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking mining_rig changes.

  ## Examples

      iex> change_mining_rig(mining_rig)
      %Ecto.Changeset{data: %MiningRig{}}

  """
  def change_mining_rig(%MiningRig{} = mining_rig, attrs \\ %{}) do
    MiningRig.changeset(mining_rig, attrs)
  end

  def query_filter_by_type(query, nil) do
    query
    |> where([r], is_nil(r.type))
  end

  def query_filter_by_type(query, type) do
    query
    |> where([r], r.type == ^type)
  end

  def list_mining_rigs_by_query(query) do
    Repo.all(query)
  end

  def get_mining_rig_by_code(code) do
    Repo.get_by(MiningRig, code: code)
  end
end
