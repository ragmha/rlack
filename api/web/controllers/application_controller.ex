defmodule Rlack.ApplicationController do
  use Rlack.Web, :controller

  def not_found(conn, _params) do
    conn
    |> put_status(:not_found)
    |> render(Rlack.ApplicationView, "not_found.json")
  end
end
