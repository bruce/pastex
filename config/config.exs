# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

config :comeonin, Ecto.Password, Comeonin.Pbkdf2

config :comeonin, :pbkdf2_rounds, 120_000
config :comeonin, :pbkdf2_salt_len, 512

# General application configuration
config :pastex,
  ecto_repos: [Pastex.Repo]

# Configures the endpoint
config :pastex, PastexWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "mrfI7vOxk/zHbD6Fsp1n7Gu/F5MaQRw0okdTr2dgt5zMRaLodZa+dGNHPdXbYjST",
  render_errors: [view: PastexWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: Pastex.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
