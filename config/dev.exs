use Mix.Config

# For development, we disable any cache and enable
# debugging and code reloading.
#
# The watchers configuration can be used to run external
# watchers to your application. For example, we use it
# with brunch.io to recompile .js and .css sources.
config :simple_forum, SimpleForum.Endpoint,
  http: [port: 4000],
  debug_errors: true,
  code_reloader: true,
  check_origin: false,
  watchers: [node: ["node_modules/brunch/bin/brunch", "watch", "--stdin",
                    cd: Path.expand("../", __DIR__)]]


# Watch static and templates for browser reloading.
config :simple_forum, SimpleForum.Endpoint,
  live_reload: [
    patterns: [
      ~r{priv/static/.*(js|css|png|jpeg|jpg|gif|svg)$},
      ~r{priv/gettext/.*(po)$},
      ~r{web/views/.*(ex)$},
      ~r{web/templates/.*(eex)$}
    ]
  ]

# Do not include metadata nor timestamps in development logs
config :logger, :console, format: "[$level] $message\n"

# Set a higher stacktrace during development. Avoid configuring such
# in production as building large stacktraces may be expensive.
config :phoenix, :stacktrace_depth, 20

# Configure your database
config :simple_forum, SimpleForum.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "Lucca",
  password: "",
  database: "simple_forum_dev",
  hostname: "localhost",
  pool_size: 10

# Mailgun configuration
config :simple_forum,
  mailgun_domain: "https://api.mailgun.net/v3/app34f3e759ca0f46e59803bebec46d713f.mailgun.org",
  mailgun_key: "key-e53b93ef966c46826777a05acf3c8026"
