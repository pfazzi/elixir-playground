defmodule Playground.Application.PlaceOrder do
  alias Playground.Domain.Order
  alias Playground.Domain.Clock
  alias Playground.Domain.OrderRepository

  @spec execute(
          %{id: String.t(), user_id: String.t(), items: [Order.order_item_data()]},
          Clock,
          OrderRepository
        ) :: :ok
  def execute(command, clock, order_repository) do
    order =
      Order.place(
        clock,
        command.id,
        command.user_id,
        command.items
      )

    order_repository.store(order)
  end
end
