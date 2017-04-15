defmodule Rlack.RoomController do
  use Rlack.Web, :controller

  alias Rlack.Room

  plug Guardian.Plug.EnsureAuthenticated, handler: Rlack.SessionController

  def index(conn, params) do
    page =
      Rlack.Room
      |> order_by([asc: :id])
      |> Rlack.Repo.paginate(params)

    render(conn, "index.json", page: page)
  end

  def create(conn, params) do
    current_user = Guardian.Plug.current_resource(conn)
    changeset = Room.changeset(%Room{}, params)

    case Repo.insert(changeset) do
      {:ok, room} ->
        assoc_changeset = Rlack.UserRoom.changeset(
          %Rlack.UserRoom{},
          %{user_id: current_user.id, room_id: room.id}
        )
        Repo.insert(assoc_changeset)

        conn
        |> put_status(:created)
        |> render("show.json", room: room)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Rlack.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def update(conn, params) do
    room = Repo.get!(Room, params["id"])
    changeset = Room.changeset(room, params)

    case Repo.update(changeset) do
      {:ok, room} ->
        conn
        |> put_status(:ok)
        |> render("show.json", %{room: room})
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Rlack.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def join(conn, %{"id" => room_id}) do
    current_user = Guardian.Plug.current_resource(conn)
    room = Repo.get(Room, room_id)

    changeset = Rlack.UserRoom.changeset(
      %Rlack.UserRoom{},
      %{room_id: room.id, user_id: current_user.id}
    )

    case Repo.insert(changeset) do
      {:ok, _user_room} ->
        conn
        |> put_status(:created)
        |> render("show.json", %{room: room})
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Rlack.ChangesetView, "error.json", changeset: changeset)
    end
  end
end
