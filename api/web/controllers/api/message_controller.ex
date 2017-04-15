defmodule Rlack.MessageController do
  use Rlack.Web, :controller

  plug Guardian.Plug.EnsureAuthenticated, handler: Rlack.SessionController

  def index(conn, params) do
    last_seen_id = params["last_seen_id"] || 0
    room = Repo.get!(Rlack.Room, params["room_id"])

    page =
      Rlack.Message
      |> where([m], m.room_id == ^room.id)
      |> where([m], m.id < ^last_seen_id)
      |> order_by([desc: :inserted_at, desc: :id])
      |> preload(:user)
      |> Rlack.Repo.paginate()

    render(conn, "index.json", %{messages: page.entries, pagination: Rlack.PaginationHelpers.pagination(page)})
  end
end
