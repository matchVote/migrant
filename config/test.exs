use Mix.Config

config :migrant, Migrant.Repo,
  database: "matchvote_test",
  username: "postgres",
  password: "postgres",
  hostname: "matchvote_db",
  pool: Ecto.Adapters.SQL.Sandbox

config :logger, backends: []
