defmodule Migrant.Repo.Migrations.ExecuteRepsToOfficialsIdTransfer do
  use Ecto.Migration

  def up do
    Migrant.RepsToOfficials.transfer_ids()
  end

  def down do
  end
end
