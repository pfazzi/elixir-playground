defmodule Playground.Infrastructure.UI.GraphQL.Schema do
  use Absinthe.Schema

  import_types(Playground.Infrastructure.UI.GraphQL.Schema.Order)
  import_types(Playground.Infrastructure.UI.GraphQL.Schema.OrderItem)

  alias Playground.Infrastructure.UI.GraphQL.Resolvers

  query do
    @desc "Get all orders"
    field :orders, list_of(:order) do
      resolve(&Resolvers.Order.list_orders/3)
    end

    @desc "Get an order"
    field :order, :order do
      arg(:id, non_null(:id))
      resolve(&Resolvers.Order.find_order/3)
    end
  end
end
