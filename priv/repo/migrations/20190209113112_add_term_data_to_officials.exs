defmodule Migrant.Repo.Migrations.AddTermDataToOfficials do
  use Ecto.Migration

  def change do
    alter table(:officials) do
      add(:branch, :string)
      add(:status, :string)
      add(:party, :string)
      add(:state, :string)
      add(:state_rank, :string)
      add(:seniority_date, :date)
      add(:government_role, :string)
    end
  end
end
