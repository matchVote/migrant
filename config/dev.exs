use Mix.Config

config :migrant, Migrant.Repo,
  database: "matchvote_dev",
  username: "postgres",
  password: "postgres",
  hostname: "matchvote_db"
