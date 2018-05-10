use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :the_long_drag, TheLongDragWeb.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :the_long_drag, TheLongDrag.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "the_long_drag_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# Finally import the config/dev.secret.exs
# which should be versioned separately.
import_config "test.secret.exs"
