defmodule Rlack.Room do
  use Rlack.Web, :model

  schema "rooms" do
    field :name, :string
    field :topic, :string
    many_to_many :users, Rlack.User, join_through: "user_rooms"

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :topic])
    |> validate_required([:name, :topic])
    |> unique_constraint(:name)
  end
end
