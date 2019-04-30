defmodule Migrant.Repo.Migrations.CreateArticlesOfficials do
  use Ecto.Migration

  def change do
    create table(:articles_officials) do
      add(:official_id, :binary_id)
      add(:article_id, :integer)
      add(:mentioned_count, :integer, default: 0)
      timestamps(inserted_at: :created_at)
    end

    create(unique_index(:articles_officials, [:official_id, :article_id]))
  end
end
