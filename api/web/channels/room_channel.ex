defmodule Rlack.RoomChannel do
  use Rlack.Web, :channel

  def join("rooms:" <> room_id, _params, socket) do
    room = Repo.get!(Rlack.Room, room_id)

    response = %{
      room: Phoenix.View.render_one(room, Rlack.RoomView, "room.json"),
    }

    {:ok, response, assign(socket, :room, room)}
  end

  def terminate(_reason, socket) do
    {:ok, socket}
  end
end
