defmodule Playground.Infrastructure.UI.GraphQL.Schema.Order do
  use Absinthe.Schema.Notation

  object :order do
    field(:id, :id)
    field(:user_id, :string)
    field(:timestamp, :string)
    field(:items, list_of(:order_item))
  end
end
