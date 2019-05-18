defmodule Migrant.RepoCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      alias Migrant.Repo

      import Ecto
      import Ecto.Query
      import Migrant.RepoCase
    end
  end

  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Migrant.Repo)

    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(Migrant.Repo, {:shared, self()})
    end

    :ok
  end
end
