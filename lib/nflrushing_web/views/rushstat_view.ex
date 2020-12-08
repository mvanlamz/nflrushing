defmodule NflrushingWeb.RushstatView do
  use NflrushingWeb, :view

  def long_title(field_name) do
    %{
      attempts_count: gettext("Rushing Attempts"),
      attempts_per_game_avg: gettext("Rushing Attempts Per Game Average"),
      first_down_count: gettext("Rushing First Downs"),
      first_down_percent: gettext("Rushing First Down Percentage"),
      forty_yards_count: gettext("Rushing 40+ Yards Each"),
      fumble_count: gettext("Rushing Fumbles"),
      player_name: gettext("Player's Name"),
      player_position: gettext("Player's Position"),
      team_name: gettext("Player's Team Abbreviation"),
      touchdowns_count: gettext("Total Rushing Touchdowns"),
      twenty_yards_count: gettext("Rushing 20+ Yards Each"),
      yards_avg_per_attempt: gettext("Rushing Average Yards Per Attempt"),
      yards_max: gettext("Longest Rush -- T indicates a touchdown"),
      yards_max_touchdown: gettext("Longest Rush Touchdown"),
      yards_per_game: gettext("Rushing Yards Per Game"),
      yards_total: gettext("Total Rushing Yards")
    }[field_name]
  end

  def short_title(field_name) do
    %{
      attempts_count: gettext("Att"),
      attempts_per_game_avg: gettext("Att/G"),
      first_down_count: gettext("1st"),
      first_down_percent: gettext("1st%"),
      forty_yards_count: gettext("40+"),
      fumble_count: gettext("FUM"),
      player_name: gettext("Player"),
      player_position: gettext("Pos"),
      team_name: gettext("Team"),
      touchdowns_count: gettext("TD"),
      twenty_yards_count: gettext("20+"),
      yards_avg_per_attempt: gettext("Avg"),
      yards_max: gettext("Lng"),
      yards_max_touchdown: gettext("LngT"),
      yards_per_game: gettext("Yds/G"),
      yards_total: gettext("Yds")
    }[field_name]
  end
end
