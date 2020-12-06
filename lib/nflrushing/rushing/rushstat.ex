defmodule Nflrushing.Rushing.Rushstat do
  use Ecto.Schema
  import Ecto.Changeset

  schema "rushstats" do
    field :attempts_count, :integer
    field :attempts_per_game_avg, :float
    field :first_down_count, :integer
    field :first_down_percent, :float
    field :forty_yards_count, :integer
    field :fumble_count, :integer
    field :player_name, :string
    field :player_position, :string
    field :team_name, :string
    field :touchdowns_count, :integer
    field :twenty_yards_count, :integer
    field :yards_avg_per_attempt, :float
    field :yards_max, :integer
    field :yards_max_touchdown, :boolean, default: false
    field :yards_per_game, :float
    field :yards_total, :integer

    timestamps()
  end

  @doc false
  def changeset(rushstat, attrs) do
    rushstat
    |> cast(attrs, [
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
      :yards_max_touchdown,
      :first_down_count,
      :first_down_percent,
      :twenty_yards_count,
      :forty_yards_count,
      :fumble_count
    ])
    |> validate_required([
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
      :yards_max_touchdown,
      :first_down_count,
      :first_down_percent,
      :twenty_yards_count,
      :forty_yards_count,
      :fumble_count
    ])
  end
end
