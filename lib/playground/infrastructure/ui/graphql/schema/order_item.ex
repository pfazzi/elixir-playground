defmodule Playground.Infrastructure.UI.GraphQL.Schema.OrderItem do
  use Absinthe.Schema.Notation

  @desc "An order item"
  object :order_item do
    field(:row_number, :integer)
    field(:description, :string)
    field(:qty, :integer)
  end
end
