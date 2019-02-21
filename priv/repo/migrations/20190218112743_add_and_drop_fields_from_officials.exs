defmodule Migrant.Repo.Migrations.AddAndDropFieldsFromOfficials do
  use Ecto.Migration

  def change do
    alter table(:officials) do
      remove(:bioguide_id, :string)
      remove(:media, :map)
      remove(:branch, :string)
      remove(:party, :string)
      remove(:state, :string)
      remove(:state_rank, :string)
      remove(:seniority_date, :date)
      remove(:government_role, :string)
      remove(:contact_form, :text)
      remove(:phone_number, :string)
      remove(:emails, {:array, :string})
      remove(:website, :text)
      remove(:address, :map)

      add(:mv_key, :text, null: false)
      add(:identifiers, :map)
      add(:sexual_orientation, :string)
      add(:profile_pic, :text)
    end

    create(unique_index(:officials, [:mv_key]))
  end
end
