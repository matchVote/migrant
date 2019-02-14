defmodule Migrant.Repo.Migrations.AddSlugToOfficials do
  use Ecto.Migration

  def change do
    alter table(:officials) do
      add(:slug, :string)
    end

    create(unique_index(:officials, [:slug]))
  end
end
