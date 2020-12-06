defmodule Mix.Tasks.LoadJson do
  use Mix.Task

  alias Nflrushing.Rushing

  @shortdoc "Populates the database with the given JSON file."
  def run(_) do
    Mix.Task.run("app.start")
    # TODO handle file and database errors
    {:ok, body} = File.read("../nflrushing/rushing.json")
    {:ok, json} = Jason.decode(body)

    for j <- json do
      Rushing.create_rushstat(%{
        attempts_count: to_integer(j["Att"]),
        attempts_per_game_avg: to_float(j["Att/G"]),
        player_name: j["Player"],
        player_position: j["Pos"],
        first_down_count: to_integer(j["1st"]),
        first_down_percent: to_float(j["1st%"]),
        forty_yards_count: to_integer(j["40+"]),
        fumble_count: to_integer(j["FUM"]),
        touchdowns_count: to_integer(j["TD"]),
        twenty_yards_count: to_integer(j["20+"]),
        yards_avg_per_attempt: to_float(j["Avg"]),
        yards_max: to_integer(j["Lng"]),
        yards_max_touchdown: Rushing.is_touchdown?("#{j["Lng"]}"),
        yards_per_game: to_float(j["Yds/G"]),
        yards_total: to_integer(j["Yds"]),
        team_name: j["Team"]
      })
    end
  end

  defp to_float(given) do
    "#{given}" |> String.replace(",", "") |> Float.parse() |> Kernel.elem(0)
  end

  defp to_integer(given) do
    "#{given}" |> String.replace(",", "") |> Integer.parse() |> Kernel.elem(0)
  end
end
