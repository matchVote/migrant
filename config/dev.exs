use Mix.Config

config :migrator, Migrator.Repo,
  database: "matchvote_dev",
  username: "postgres",
  password: "postgres",
  hostname: "matchvote_db"
