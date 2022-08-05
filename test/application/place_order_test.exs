defmodule PlaygroundTest.Application.PlaceOrderTest do
  use ExUnit.Case

  alias Playground.Application.PlaceOrder
  alias Playground.Domain.Money
  alias Playground.Infrastructure.MockClock

  test "it handles the placement of a new order" do
    clock = MockClock.with_now(~U[2022-01-12 00:01:00.00Z])

    defmodule MockRepository do
      def store(_order), do: :ok
    end

    command = %PlaceOrder{
      id: "50954707-5cc2-4737-ad54-a33700ad8bdc",
      user_id: "cc727cc2-9ad6-4fea-b523-12047aaffedd",
      items: [
        %{description: "Caffè", qty: 1, price: %Money{amount_in_mills: 6_000}},
        %{description: "Acqua", qty: 1, price: %Money{amount_in_mills: 2_900}}
      ]
    }

    assert :ok = PlaceOrder.execute(command, clock, MockRepository)
  end
end
