defmodule Migrant.Repo.Migrations.AddNameRecognitionToOfficials do
  use Ecto.Migration

  def change do
    alter table(:officials) do
      add(:name_recognition, :integer, default: 0)
    end
  end
end
