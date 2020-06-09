defmodule RadioPhilo.Repo do
  use Ecto.Repo,
    otp_app: :radioPhilo,
    adapter: Ecto.Adapters.Postgres
end
