use Mix.Config

config :migrant, Migrant.Repo,
  database: "matchvote_test",
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  port: 5653,
  pool: Ecto.Adapters.SQL.Sandbox

config :logger, backends: []
