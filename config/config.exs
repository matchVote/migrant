use Mix.Config

config :migrant, ecto_repos: [Migrant.Repo]

import_config "#{Mix.env()}.exs"
