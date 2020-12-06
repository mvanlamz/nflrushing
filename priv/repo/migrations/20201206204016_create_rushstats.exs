defmodule Nflrushing.Repo.Migrations.CreateRushstats do
  use Ecto.Migration

  def change do
    create table(:rushstats) do
      add :player_name, :string
      add :team_name, :string
      add :player_position, :string
      add :attempts_count, :integer
      add :attempts_per_game_avg, :float
      add :yards_total, :integer
      add :yards_avg_per_attempt, :float
      add :yards_per_game, :float
      add :touchdowns_count, :integer
      add :yards_max, :integer
      add :yards_max_touchdown, :boolean, default: false, null: false
      add :first_down_count, :integer
      add :first_down_percent, :float
      add :twenty_yards_count, :integer
      add :forty_yards_count, :integer
      add :fumble_count, :integer

      timestamps()
    end
  end
end
