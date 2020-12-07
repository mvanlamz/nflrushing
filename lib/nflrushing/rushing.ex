defmodule Nflrushing.Rushing do
  @moduledoc """
  The Rushing context.
  """

  import Ecto.Query, warn: false
  alias Nflrushing.Repo

  alias Nflrushing.Rushing.Player
  alias Nflrushing.Rushing.Rushstat

  @doc """
  Returns the list of filtered and sorted rushstats.

  ## Examples

      iex> list_rushstats()
      [%Rushstat{}, ...]

  """
  def list_rushstats(params) do
    # IO.inspect(params)
    # player_name = params{:filter_by}
    Rushstat
    # |> where_player_name_like(params["player_name"])
    |> where_player_name_exact(params["player_name"])
    |> order_by(asc: :id)
    |> Repo.all()
  end

  defp where_player_name_exact(query, _player_name = nil), do: query

  defp where_player_name_exact(query, player_name) do
   query
  |> where(player_name: ^player_name)
  end

  @doc """
  Returns the list of rushstats.

  ## Examples

      iex> list_rushstats()
      [%Rushstat{}, ...]

  """
  def list_rushstats do
    Repo.all(Rushstat)
  end

  @doc """
  Gets a single rushstat.

  Raises `Ecto.NoResultsError` if the Rushstat does not exist.

  ## Examples

      iex> get_rushstat!(123)
      %Rushstat{}

      iex> get_rushstat!(456)
      ** (Ecto.NoResultsError)

  """
  def get_rushstat!(id), do: Repo.get!(Rushstat, id)

  @doc """
  Creates a rushstat.

  ## Examples

      iex> create_rushstat(%{field: value})
      {:ok, %Rushstat{}}

      iex> create_rushstat(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_rushstat(attrs \\ %{}) do
    %Rushstat{}
    |> Rushstat.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a rushstat.

  ## Examples

      iex> update_rushstat(rushstat, %{field: new_value})
      {:ok, %Rushstat{}}

      iex> update_rushstat(rushstat, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_rushstat(%Rushstat{} = rushstat, attrs) do
    rushstat
    |> Rushstat.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a rushstat.

  ## Examples

      iex> delete_rushstat(rushstat)
      {:ok, %Rushstat{}}

      iex> delete_rushstat(rushstat)
      {:error, %Ecto.Changeset{}}

  """
  def delete_rushstat(%Rushstat{} = rushstat) do
    Repo.delete(rushstat)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking rushstat changes.

  ## Examples

      iex> change_rushstat(rushstat)
      %Ecto.Changeset{data: %Rushstat{}}

  """
  def change_rushstat(%Rushstat{} = rushstat, attrs \\ %{}) do
    Rushstat.changeset(rushstat, attrs)
  end

  @doc """
  Returns true if Lng field from JSON file indicates a touchdown, false otherwise.

  ## Examples

      iex> is_touchdown?("75T")
      true
      iex> is_touchdown?("9")
      false

  """
  def is_touchdown?(given) do
    # TODO touchdown if Lng field from JSON file ends in a "T"
    String.match?("#{given}", ~r/[0-9]+T/)
  end
end
