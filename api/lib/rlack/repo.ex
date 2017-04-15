defmodule Rlack.Repo do
  use Ecto.Repo, otp_app: :rlack
  use Scrivener, page_size: 25
end
