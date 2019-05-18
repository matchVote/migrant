defmodule Migrant.RepsToOfficials do
  import Ecto.Query
  alias Migrant.Repo
  alias Migrant.Schemas.{Representative}

  def transfer_ids do
    from(r in Representative, select: r.id)
    |> Repo.all()
  end
end
