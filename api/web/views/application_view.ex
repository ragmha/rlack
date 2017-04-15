defmodule Rlack.ApplicationView do
  use Rlack.Web, :view

  def render("not_found.json", _) do
    %{error: "Not found"}
  end
end
