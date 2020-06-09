# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :radioPhilo,
  ecto_repos: [RadioPhilo.Repo]

# Configures the endpoint
config :radioPhilo, RadioPhiloWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "J1swCiy+rEJKs4U12vAU0YbHCMy4EjlmA//9I0uR/wOHIM/x0nKywrlwZqpc87HX",
  render_errors: [view: RadioPhiloWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: RadioPhilo.PubSub,
  live_view: [signing_salt: "QvhP5rYI"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
