defmodule Migrant.Schemas.Official do
  use Ecto.Schema

  @primary_key {:id, :binary_id, autogenerate: true}

  schema "officials" do
    field(:first_name, :string)
    field(:last_name, :string)
    field(:middle_name, :string)
    field(:suffix, :string)
    field(:mv_key, :string)
    timestamps(inserted_at: :created_at)
  end
end
