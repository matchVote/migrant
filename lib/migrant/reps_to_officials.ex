defmodule Migrant.RepsToOfficials do
  import Ecto.Query
  alias Migrant.Repo
  alias Migrant.Schemas.{Official, Representative}

  def transfer_ids do
    from(o in Official,
      join: r in Representative,
      on:
        r.first_name == o.first_name and r.last_name == o.last_name and
          coalesce(r.middle_name, "") == coalesce(o.middle_name, ""),
      select: {o.id, r.id}
    )
    |> Repo.all()
    |> Enum.each(fn {official_id, rep_id} ->
      from(o in Official, where: o.id == ^official_id)
      |> Repo.update_all(set: [id: rep_id])
    end)
  end
end
