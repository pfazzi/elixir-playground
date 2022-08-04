defmodule Playground.Infrastructure.Database.Repo do
  use Ecto.Repo,
    otp_app: :playground,
    adapter: Ecto.Adapters.Postgres
end
