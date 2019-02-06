defmodule Migrant.Application do
  use Application

  def start(_type, _args) do
    children = [
      Migrant.Repo
    ]

    opts = [strategy: :one_for_one, name: Migrant.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
