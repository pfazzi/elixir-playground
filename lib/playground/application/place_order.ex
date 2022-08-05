defmodule Playground.Application.PlaceOrder do
  alias Playground.Domain.Order
  alias Playground.Domain.Clock
  alias Playground.Domain.OrderRepository

  @type t() :: %__MODULE__{id: String.t(), user_id: String.t(), items: [Order.order_item_data()]}
  @enforce_keys [:id, :user_id, :items]
  defstruct [:id, :user_id, :items]

  @spec execute(
          %__MODULE__{},
          Clock,
          OrderRepository
        ) :: :ok | {:error, String.t()}
  def execute(command, clock, order_repository) do
    order =
      Order.place(
        clock,
        command.id,
        command.user_id,
        command.items
      )

    order_repository.store(order)

    :ok
  end
end
