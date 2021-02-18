defmodule Min.Repo do
  use Ecto.Repo,
    otp_app: :min,
    adapter: Ecto.Adapters.Postgres
end
