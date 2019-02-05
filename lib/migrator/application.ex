defmodule Migrator.Application do
  use Application

  def start(_type, _args) do
    children = [
      Migrator.Repo
    ]

    opts = [strategy: :one_for_one, name: Migrator.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
