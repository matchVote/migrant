defmodule Migrant.Repo do
  use Ecto.Repo,
    otp_app: :migrant,
    adapter: Ecto.Adapters.Postgres
end
