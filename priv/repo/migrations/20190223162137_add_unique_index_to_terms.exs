defmodule Migrant.Repo.Migrations.AddUniqueIndexToTerms do
  use Ecto.Migration

  def change do
    create(unique_index(:terms, [:official_id, :start_date]))
  end
end
