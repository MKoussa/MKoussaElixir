defmodule Mkoussaelixir.Repo do
  use Ecto.Repo,
    otp_app: :mkoussaelixir,
    adapter: Ecto.Adapters.Postgres
end
