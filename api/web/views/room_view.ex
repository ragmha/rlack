defmodule Rlack.RoomView do
  use Rlack.Web, :view

  def render("index.json", %{page: page}) do
    %{
      data: render_many(page.entries, Rlack.RoomView, "room.json"),
      pagination: Rlack.PaginationHelpers.pagination(page)
    }
  end

  def render("show.json", %{room: room}) do
    %{data: render_one(room, Rlack.RoomView, "room.json")}
  end

  def render("room.json", %{room: room}) do
    %{
      id: room.id,
      name: room.name,
      topic: room.topic
    }
  end
end
