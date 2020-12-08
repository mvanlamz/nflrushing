defmodule Nflrushing.Rushing do
  @moduledoc """
  The Rushing context.
  """

  import Ecto.Query, warn: false
  alias Nflrushing.Repo
  alias Nflrushing.Rushing.Rushstat

  @doc """
  Returns the list of filtered and sorted rushstats.

  ## Examples

      iex> list_rushstats()
      [%Rushstat{}, ...]

  """
  def list_rushstats(params) do
    Rushstat
    # |> where_player_name_like(params["player_name"])  TODO
    |> where_player_name_exact(params["player_name"])
    |> order_by_selected(params["sort_by"])
    |> Repo.all()
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

  defp where_player_name_exact(query, player_name) when player_name in [nil, ""], do: query

  defp where_player_name_exact(query, player_name) do
    query
    |> where(player_name: ^player_name)
  end

  defp order_by_selected(query, field)
       when field in ["yards_total", "yards_max", "touchdowns_count"] do
    field = String.to_atom(field)

    query
    |> order_by(desc: ^field)
  end

  defp order_by_selected(query, _field) do
    query
    |> order_by(asc: :id)
  end

  def csv_rushstats(params) do
    [
      [
        :player_name,
        :team_name,
        :player_position,
        :attempts_count,
        :attempts_per_game_avg,
        :yards_total,
        :yards_avg_per_attempt,
        :yards_per_game,
        :touchdowns_count,
        :yards_max,
        :first_down_count,
        :first_down_percent,
        :twenty_yards_count,
        :forty_yards_count,
        :fumble_count
      ]
    ] ++
      for r <- list_rushstats(params) do
        [
          r.player_name,
          r.team_name,
          r.player_position,
          r.attempts_count,
          r.attempts_per_game_avg,
          r.yards_total,
          r.yards_avg_per_attempt,
          r.yards_per_game,
          r.touchdowns_count,
          "#{r.yards_max}#{
            if r.yards_max_touchdown do
              "T"
            end
          }",
          r.first_down_count,
          r.first_down_percent,
          r.twenty_yards_count,
          r.forty_yards_count,
          r.fumble_count
        ]
      end
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
