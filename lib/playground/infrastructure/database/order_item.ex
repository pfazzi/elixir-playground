defmodule Playground.Infrastructure.Database.OrderItem do
  use Ecto.Schema

  @primary_key false

  schema "order_item" do
    field(:order_id, :binary_id, primary_key: true)
    field(:row_number, :integer, primary_key: true)
    field(:description, :string)
    field(:qty, :integer)
    field(:price_amount_in_mills, :integer)
    field(:price_currency, :string)
  end
end
