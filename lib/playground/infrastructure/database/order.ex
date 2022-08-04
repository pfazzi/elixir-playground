defmodule Playground.Infrastructure.Database.Order do
  use Ecto.Schema

  @primary_key {:id, :binary_id, autogenerate: false}

  schema "order" do
    field(:user_id, :binary_id)
    field(:timestamp, :utc_datetime)
    has_many(:items, Playground.Infrastructure.Database.OrderItem)
  end
end
