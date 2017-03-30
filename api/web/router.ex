defmodule Rlack.Router do
  use Rlack.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", Rlack do
    pipe_through :api
  end
end
