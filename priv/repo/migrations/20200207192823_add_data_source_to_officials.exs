defmodule Migrant.Repo.Migrations.AddDataSourceToOfficials do
  use Ecto.Migration

  def change do
    alter table(:officials) do
      add(:data_source, :text)
    end
  end
end
