defmodule NflrushingWeb.RushstatControllerTest do
  use NflrushingWeb.ConnCase

  alias Nflrushing.Rushing

  @create_attrs %{
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
    yards_per_game: 42.1,
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
    yards_per_game: 43.2,
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

  def fixture(:rushstat) do
    {:ok, rushstat} = Rushing.create_rushstat(@create_attrs)
    rushstat
  end

  describe "index" do
    test "lists all rushstats", %{conn: conn} do
      conn = get(conn, Routes.rushstat_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Rushstats"
    end
  end

  describe "new rushstat" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.rushstat_path(conn, :new))
      assert html_response(conn, 200) =~ "New Rushstat"
    end
  end

  describe "create rushstat" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.rushstat_path(conn, :create), rushstat: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.rushstat_path(conn, :show, id)

      conn = get(conn, Routes.rushstat_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Rushstat"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.rushstat_path(conn, :create), rushstat: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Rushstat"
    end
  end

  describe "edit rushstat" do
    setup [:create_rushstat]

    test "renders form for editing chosen rushstat", %{conn: conn, rushstat: rushstat} do
      conn = get(conn, Routes.rushstat_path(conn, :edit, rushstat))
      assert html_response(conn, 200) =~ "Edit Rushstat"
    end
  end

  describe "update rushstat" do
    setup [:create_rushstat]

    test "redirects when data is valid", %{conn: conn, rushstat: rushstat} do
      conn = put(conn, Routes.rushstat_path(conn, :update, rushstat), rushstat: @update_attrs)
      assert redirected_to(conn) == Routes.rushstat_path(conn, :show, rushstat)

      conn = get(conn, Routes.rushstat_path(conn, :show, rushstat))
      assert html_response(conn, 200) =~ "some updated player_name"
    end

    test "renders errors when data is invalid", %{conn: conn, rushstat: rushstat} do
      conn = put(conn, Routes.rushstat_path(conn, :update, rushstat), rushstat: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Rushstat"
    end
  end

  describe "delete rushstat" do
    setup [:create_rushstat]

    test "deletes chosen rushstat", %{conn: conn, rushstat: rushstat} do
      conn = delete(conn, Routes.rushstat_path(conn, :delete, rushstat))
      assert redirected_to(conn) == Routes.rushstat_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.rushstat_path(conn, :show, rushstat))
      end
    end
  end

  defp create_rushstat(_) do
    rushstat = fixture(:rushstat)
    %{rushstat: rushstat}
  end
end
