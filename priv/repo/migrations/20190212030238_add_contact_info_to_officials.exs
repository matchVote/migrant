defmodule Migrant.Repo.Migrations.AddContactInfoToOfficials do
  use Ecto.Migration

  def change do
    alter table(:officials) do
      add(:contact_form, :text)
      add(:phone_number, :string)
      add(:emails, {:array, :string})
      add(:website, :text)
      add(:address, :map)
    end
  end
end
