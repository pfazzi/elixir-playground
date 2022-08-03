defmodule PlaygroundTest.Infrastructure.OrderRepositoryTest do
  use ExUnit.Case
  doctest Playground

  alias Playground.Domain.Order
  alias Playground.Infrastructure.PostgresUserRepository

  test "it stores orders into the database" do
    stored_order = %Order{
      id: "50954707-5cc2-4737-ad54-a33700ad8bdc",
      user_id: "cc727cc2-9ad6-4fea-b523-12047aaffedd",
      timestamp: ~U[2022-01-12 00:01:00.00Z],
      items: [
        %OrderItem{description: "Caffè", qty: 1, price: %Money{amount_in_mills: 6_000}},
        %OrderItem{description: "Acqua", qty: 1, price: %Money{amount_in_mills: 2_900}}
      ]
    }

    PostgresUserRepository.store(stored_order)

    retrieved_order = PostgresUserRepository.get("50954707-5cc2-4737-ad54-a33700ad8bdc")

    assert stored_order == retrieved_order
  end
end