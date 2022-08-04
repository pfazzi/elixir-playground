defmodule PlaygroundTest.Domain.OrderTest do
  use ExUnit.Case

  alias Playground.Domain.Money
  alias Playground.Domain.Order
  alias Playground.Domain.OrderItem
  alias Playground.Infrastructure.MockClock

  test "it can be placed" do
    clock = MockClock.with_now(~U[2022-01-12 00:01:00.00Z])

    order =
      Order.place(
        clock,
        "50954707-5cc2-4737-ad54-a33700ad8bdc",
        "cc727cc2-9ad6-4fea-b523-12047aaffedd",
        [
          %{row_number: 1, description: "Caffè", qty: 1, price: %Money{amount_in_mills: 6_000}},
          %{row_number: 2, description: "Acqua", qty: 1, price: %Money{amount_in_mills: 2_900}}
        ]
      )

    expected_order = %Order{
      id: "50954707-5cc2-4737-ad54-a33700ad8bdc",
      user_id: "cc727cc2-9ad6-4fea-b523-12047aaffedd",
      timestamp: ~U[2022-01-12 00:01:00.00Z],
      items: [
        %OrderItem{
          row_number: 1,
          description: "Caffè",
          qty: 1,
          price: %Money{amount_in_mills: 6_000}
        },
        %OrderItem{
          row_number: 2,
          description: "Acqua",
          qty: 1,
          price: %Money{amount_in_mills: 2_900}
        }
      ]
    }

    assert order == expected_order
  end
end
