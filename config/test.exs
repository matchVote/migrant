use Mix.Config

config :migrator, Migrator.Repo,
  database: "matchvote_test",
  username: "postgres",
  password: "postgres",
  hostname: "matchvote_db",
  pool: Ecto.Adapters.SQL.Sandbox

config :logger, backends: []
