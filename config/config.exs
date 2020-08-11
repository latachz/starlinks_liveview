# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :starlinks,
  ecto_repos: [Starlinks.Repo]

# Configures the endpoint
config :starlinks, StarlinksWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "M8fjgaQg1uccfx6vPpFKNtCqj5oEUo7qD8M/q8OTFgCwHKrlpntERafXrJT+woOk",
  render_errors: [view: StarlinksWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Starlinks.PubSub,
  live_view: [signing_salt: "aGlRv4t6"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
