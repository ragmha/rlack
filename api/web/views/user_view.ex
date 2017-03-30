defmodule Rlack.UserView do
  use Rlack.Web, :view

  def render("user.json", %{user: user}) do
    %{
      id: user.id,
      username: user.username,
      email: user.email,
    }
  end
end
