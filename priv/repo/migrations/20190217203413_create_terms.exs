defmodule Migrant.Repo.Migrations.CreateTerms do
  use Ecto.Migration

  def change do
    create table(:terms, primary_key: false) do
      add(:id, :binary_id, primary_key: true, default: fragment("uuid_generate_v4()"))
      add(:start_date, :date)
      add(:end_date, :date)
      add(:role, :string)
      add(:party, :string)
      add(:state, :string)
      add(:state_rank, :string)
      add(:contact_form, :text)
      add(:phone_number, :string)
      add(:fax_number, :string)
      add(:emails, {:array, :string}, default: [])
      add(:website, :text)
      add(:address, :map)
      # federal, state, county, city
      add(:level, :string)
      # executive, legislative, judicial (only if level is federal), nil
      add(:branch, :string)
      add(:official_id, references(:officials, type: :binary_id, on_delete: :delete_all))
      timestamps()
    end

    create(index(:terms, [:official_id]))
  end
end
