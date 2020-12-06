defmodule Nflrushing.RushingTest do
  use Nflrushing.DataCase

  alias Nflrushing.Rushing

  describe "players" do
    alias Nflrushing.Rushing.Player

    @valid_attrs %{
      attempts_count: 42,
      attempts_per_game_avg: 120.5,
      name: "some name",
      player_position: "some player_position",
      rush_first_down_count: 42,
      rush_first_down_percent: 120.5,
      rush_forty_yards_count: 42,
      rush_fumble_count: 42,
      rush_touchdowns_count: 42,
      rush_twenty_yards_count: 42,
      rush_yards_avg: 120.5,
      rush_yards_max: 42,
      rush_yards_max_touchdown: true,
      rush_yards_per_game: 42,
      rush_yards_total: 42,
      team_nickname: "some team_nickname"
    }
    @update_attrs %{
      attempts_count: 43,
      attempts_per_game_avg: 456.7,
      name: "some updated name",
      player_position: "some updated player_position",
      rush_first_down_count: 43,
      rush_first_down_percent: 456.7,
      rush_forty_yards_count: 43,
      rush_fumble_count: 43,
      rush_touchdowns_count: 43,
      rush_twenty_yards_count: 43,
      rush_yards_avg: 456.7,
      rush_yards_max: 43,
      rush_yards_max_touchdown: false,
      rush_yards_per_game: 43,
      rush_yards_total: 43,
      team_nickname: "some updated team_nickname"
    }
    @invalid_attrs %{
      attempts_count: nil,
      attempts_per_game_avg: nil,
      name: nil,
      player_position: nil,
      rush_first_down_count: nil,
      rush_first_down_percent: nil,
      rush_forty_yards_count: nil,
      rush_fumble_count: nil,
      rush_touchdowns_count: nil,
      rush_twenty_yards_count: nil,
      rush_yards_avg: nil,
      rush_yards_max: nil,
      rush_yards_max_touchdown: nil,
      rush_yards_per_game: nil,
      rush_yards_total: nil,
      team_nickname: nil
    }

    test "is_touchdown?/1 returns true or false" do
      assert true == Rushing.is_touchdown?("75T")
      assert false == Rushing.is_touchdown?("23")
      assert false == Rushing.is_touchdown?("")
    end
  end

  describe "rushstats" do
    alias Nflrushing.Rushing.Rushstat

    @valid_attrs %{
      attempts_count: 42,
      attempts_per_game_avg: 120.5,
      first_down_count: 42,
      first_down_percent: 120.5,
      forty_yards_count: 42,
      fumble_count: 42,
      player_name: "some player_name",
      player_position: "some player_position",
      team_name: "some team_name",
      touchdowns_count: 42,
      twenty_yards_count: 42,
      yards_avg_per_attempt: 120.5,
      yards_max: 42,
      yards_max_touchdown: true,
      yards_per_game: 42,
      yards_total: 42
    }
    @update_attrs %{
      attempts_count: 43,
      attempts_per_game_avg: 456.7,
      first_down_count: 43,
      first_down_percent: 456.7,
      forty_yards_count: 43,
      fumble_count: 43,
      player_name: "some updated player_name",
      player_position: "some updated player_position",
      team_name: "some updated team_name",
      touchdowns_count: 43,
      twenty_yards_count: 43,
      yards_avg_per_attempt: 456.7,
      yards_max: 43,
      yards_max_touchdown: false,
      yards_per_game: 43,
      yards_total: 43
    }
    @invalid_attrs %{
      attempts_count: nil,
      attempts_per_game_avg: nil,
      first_down_count: nil,
      first_down_percent: nil,
      forty_yards_count: nil,
      fumble_count: nil,
      player_name: nil,
      player_position: nil,
      team_name: nil,
      touchdowns_count: nil,
      twenty_yards_count: nil,
      yards_avg_per_attempt: nil,
      yards_max: nil,
      yards_max_touchdown: nil,
      yards_per_game: nil,
      yards_total: nil
    }

    def rushstat_fixture(attrs \\ %{}) do
      {:ok, rushstat} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Rushing.create_rushstat()

      rushstat
    end

    test "list_rushstats/0 returns all rushstats" do
      rushstat = rushstat_fixture()
      assert Rushing.list_rushstats() == [rushstat]
    end

    test "get_rushstat!/1 returns the rushstat with given id" do
      rushstat = rushstat_fixture()
      assert Rushing.get_rushstat!(rushstat.id) == rushstat
    end

    test "create_rushstat/1 with valid data creates a rushstat" do
      assert {:ok, %Rushstat{} = rushstat} = Rushing.create_rushstat(@valid_attrs)
      assert rushstat.attempts_count == 42
      assert rushstat.attempts_per_game_avg == 120.5
      assert rushstat.first_down_count == 42
      assert rushstat.first_down_percent == 120.5
      assert rushstat.forty_yards_count == 42
      assert rushstat.fumble_count == 42
      assert rushstat.player_name == "some player_name"
      assert rushstat.player_position == "some player_position"
      assert rushstat.team_name == "some team_name"
      assert rushstat.touchdowns_count == 42
      assert rushstat.twenty_yards_count == 42
      assert rushstat.yards_avg_per_attempt == 120.5
      assert rushstat.yards_max == 42
      assert rushstat.yards_max_touchdown == true
      assert rushstat.yards_per_game == 42
      assert rushstat.yards_total == 42
    end

    test "create_rushstat/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Rushing.create_rushstat(@invalid_attrs)
    end

    test "update_rushstat/2 with valid data updates the rushstat" do
      rushstat = rushstat_fixture()
      assert {:ok, %Rushstat{} = rushstat} = Rushing.update_rushstat(rushstat, @update_attrs)
      assert rushstat.attempts_count == 43
      assert rushstat.attempts_per_game_avg == 456.7
      assert rushstat.first_down_count == 43
      assert rushstat.first_down_percent == 456.7
      assert rushstat.forty_yards_count == 43
      assert rushstat.fumble_count == 43
      assert rushstat.player_name == "some updated player_name"
      assert rushstat.player_position == "some updated player_position"
      assert rushstat.team_name == "some updated team_name"
      assert rushstat.touchdowns_count == 43
      assert rushstat.twenty_yards_count == 43
      assert rushstat.yards_avg_per_attempt == 456.7
      assert rushstat.yards_max == 43
      assert rushstat.yards_max_touchdown == false
      assert rushstat.yards_per_game == 43
      assert rushstat.yards_total == 43
    end

    test "update_rushstat/2 with invalid data returns error changeset" do
      rushstat = rushstat_fixture()
      assert {:error, %Ecto.Changeset{}} = Rushing.update_rushstat(rushstat, @invalid_attrs)
      assert rushstat == Rushing.get_rushstat!(rushstat.id)
    end

    test "delete_rushstat/1 deletes the rushstat" do
      rushstat = rushstat_fixture()
      assert {:ok, %Rushstat{}} = Rushing.delete_rushstat(rushstat)
      assert_raise Ecto.NoResultsError, fn -> Rushing.get_rushstat!(rushstat.id) end
    end

    test "change_rushstat/1 returns a rushstat changeset" do
      rushstat = rushstat_fixture()
      assert %Ecto.Changeset{} = Rushing.change_rushstat(rushstat)
    end
  end
end
