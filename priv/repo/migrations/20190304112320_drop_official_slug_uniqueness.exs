defmodule Migrant.Repo.Migrations.DropOfficialSlugUniqueness do
  use Ecto.Migration

  def change do
    drop_if_exists(unique_index(:officials, [:slug]))
  end
end
