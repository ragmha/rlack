defmodule Rlack.RoomChannel do
  use Rlack.Web, :channel

  def join("rooms:" <> room_id, _params, socket) do
    room = Repo.get!(Rlack.Room, room_id)

    page =
      Rlack.Message
      |> where([m], m.room_id == ^room.id)
      |> order_by([desc: :inserted_at, desc: :id])
      |> preload(:user)
      |> Rlack.Repo.paginate()

    response = %{
      room: Phoenix.View.render_one(room, Rlack.RoomView, "room.json"),
      messages: Phoenix.View.render_many(page.entries, Rlack.MessageView, "message.json"),
      pagination: Rlack.PaginationHelpers.pagination(page)
    }

    send(self, :after_join)
    {:ok, response, assign(socket, :room, room)}
  end

  def handle_info(:after_join, socket) do
    Rlack.Presence.track(socket, socket.assigns.current_user.id, %{
      user: Phoenix.View.render_one(socket.assigns.current_user, Rlack.UserView, "user.json")
    })
    push(socket, "presence_state", Rlack.Presence.list(socket))
    {:noreply, socket}
  end

  def handle_in("new_message", params, socket) do
    changeset =
      socket.assigns.room
      |> build_assoc(:messages, user_id: socket.assigns.current_user.id)
      |> Rlack.Message.changeset(params)

    case Repo.insert(changeset) do
      {:ok, message} ->
        broadcast_message(socket, message)
        {:reply, :ok, socket}
      {:error, changeset} ->
        {:reply, {:error, Phoenix.View.render(Rlack.ChangesetView, "error.json", changeset: changeset)}, socket}
    end
  end

  def terminate(_reason, socket) do
    {:ok, socket}
  end

  defp broadcast_message(socket, message) do
    message = Repo.preload(message, :user)
    rendered_message = Phoenix.View.render_one(message, Rlack.MessageView, "message.json")
    broadcast!(socket, "message_created", rendered_message)
  end
end
