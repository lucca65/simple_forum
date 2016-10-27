# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :simple_forum,
  ecto_repos: [SimpleForum.Repo],
  file_path: "blackwords.list"

# Configures the endpoint
config :simple_forum, SimpleForum.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "8ufVyMsoVwTrNNS8XtzxpJZibV+/WhlzZClXvG1MZj2+KNS69/glibwkLNqPw6Do",
  render_errors: [view: SimpleForum.ErrorView, accepts: ~w(html json)],
  pubsub: [name: SimpleForum.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures email stuff
config :simple_forum, SimpleForum.Mailer,
  adapter: Swoosh.Adapters.Sendgrid,
  api_key: "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"

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

