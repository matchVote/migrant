use Mix.Config

config :migrator, ecto_repos: [Migrator.Repo]

import_config "#{Mix.env()}.exs"
