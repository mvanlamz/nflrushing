defmodule NflrushingWeb.RushstatController do
  use NflrushingWeb, :controller

  alias Nflrushing.Rushing
  alias Nflrushing.Rushing.Rushstat

  def index(conn, _params) do
    rushstats = Rushing.list_rushstats()
    render(conn, "index.html", rushstats: rushstats)
  end

  def new(conn, _params) do
    changeset = Rushing.change_rushstat(%Rushstat{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"rushstat" => rushstat_params}) do
    case Rushing.create_rushstat(rushstat_params) do
      {:ok, rushstat} ->
        conn
        |> put_flash(:info, "Rushstat created successfully.")
        |> redirect(to: Routes.rushstat_path(conn, :show, rushstat))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    rushstat = Rushing.get_rushstat!(id)
    render(conn, "show.html", rushstat: rushstat)
  end

  def edit(conn, %{"id" => id}) do
    rushstat = Rushing.get_rushstat!(id)
    changeset = Rushing.change_rushstat(rushstat)
    render(conn, "edit.html", rushstat: rushstat, changeset: changeset)
  end

  def update(conn, %{"id" => id, "rushstat" => rushstat_params}) do
    rushstat = Rushing.get_rushstat!(id)

    case Rushing.update_rushstat(rushstat, rushstat_params) do
      {:ok, rushstat} ->
        conn
        |> put_flash(:info, "Rushstat updated successfully.")
        |> redirect(to: Routes.rushstat_path(conn, :show, rushstat))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", rushstat: rushstat, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    rushstat = Rushing.get_rushstat!(id)
    {:ok, _rushstat} = Rushing.delete_rushstat(rushstat)

    conn
    |> put_flash(:info, "Rushstat deleted successfully.")
    |> redirect(to: Routes.rushstat_path(conn, :index))
  end
end