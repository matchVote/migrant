defmodule Migrant.Repo.Migrations.AddNotNullConstraintForStartDateOnTerms do
  use Ecto.Migration

  def up do
    alter table(:terms) do
      modify(:start_date, :date, null: false, default: "01-01-1000")
    end
  end

  def down do
    alter table(:terms) do
      modify(:start_date, :date, null: true)
    end
  end
end
