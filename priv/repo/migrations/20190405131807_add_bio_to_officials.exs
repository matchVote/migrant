defmodule Migrant.Repo.Migrations.AddBioToOfficials do
  use Ecto.Migration

  def change do
    alter table(:officials) do
      add(:bio, :text)
    end
  end
end
