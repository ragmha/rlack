defmodule Rlack.Message do
  use Rlack.Web, :model

  schema "messages" do
    field :text, :string
    belongs_to :room, Rlack.Room
    belongs_to :user, Rlack.User

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:text, :user_id, :room_id])
    |> validate_required([:text, :user_id, :room_id])
  end
end
