defmodule Rlack.RoomTest do
  use Rlack.ModelCase

  alias Rlack.Room

  @valid_attrs %{name: "some content", topic: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Room.changeset(%Room{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Room.changeset(%Room{}, @invalid_attrs)
    refute changeset.valid?
  end
end
