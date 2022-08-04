defmodule PlaygroundTest.Infrastructure.Database.EctoOrderRepositoryTest do
  use ExUnit.Case

  alias Playground.Domain.Order
  alias Playground.Domain.OrderItem
  alias Playground.Domain.Money
  alias Playground.Infrastructure.Database.EctoOrderRepository

  test "it stores orders into the database" do
    Ecto.Adapters.SQL.query!(Playground.Infrastructure.Database.Repo, "DELETE FROM \"order\"", [])

    Ecto.Adapters.SQL.query!(
      Playground.Infrastructure.Database.Repo,
      "DELETE FROM \"order_item\"",
      []
    )

    stored_order = %Order{
      id: "50954707-5cc2-4737-ad54-a33700ad8bdc",
      user_id: "cc727cc2-9ad6-4fea-b523-12047aaffedd",
      timestamp: ~U[2022-01-12 00:01:00Z],
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

    EctoOrderRepository.store(stored_order)

    retrieved_order = EctoOrderRepository.get("50954707-5cc2-4737-ad54-a33700ad8bdc")

    assert stored_order == retrieved_order
  end
end
