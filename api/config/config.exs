# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :rlack,
  ecto_repos: [Rlack.Repo]

# Configures the endpoint
config :rlack, Rlack.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "mwoToAIcVe0NNGxGnJP4vCfdGk9RFjDIeYhAt40rlu7ZQgg7Of8oiBeQ1Tg2WDAS",
  render_errors: [view: Rlack.ErrorView, accepts: ~w(json)],
  pubsub: [name: Rlack.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Configures Guardian
config :guardian, Guardian,
  issuer: "Rlack",
  ttl: {30, :days},
  verify_issuer: true,
  serializer: Rlack.GuardianSerializer

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
