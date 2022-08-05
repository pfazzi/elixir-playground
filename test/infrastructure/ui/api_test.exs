defmodule PlaygroundTest.Infrastructure.UI.ApiTest do
  use ExUnit.Case, async: true
  use Plug.Test

  alias Playground.Infrastructure.Database.Endpoint
  alias Playground.Infrastructure.Database.Order, as: EctoOrder
  alias Playground.Infrastructure.Database.OrderItem, as: EctoOrderItem
  alias Playground.Infrastructure.Database.Repo
  alias Playground.Infrastructure.UI.Endpoint

  @opts Endpoint.init([])

  test "returns a successful response from place order endpoint" do
    Ecto.Adapters.SQL.query!(Playground.Infrastructure.Database.Repo, "DELETE FROM \"order\"", [])

    Ecto.Adapters.SQL.query!(
      Playground.Infrastructure.Database.Repo,
      "DELETE FROM \"order_item\"",
      []
    )

    conn =
      conn(:post, "/api/orders", ~s(
      {
        "id": "397ed1a8-5cda-4bfc-a123-102a9c72c25b",
        "user_id": "235be692-65c4-4e59-a3ea-4b034fe2e4e8",
        "items": []
      }
    ))
      |> put_req_header("content-type", "application/json")

    conn = Endpoint.call(conn, @opts)

    assert conn.state == :sent
    assert conn.status == 201
    assert conn.resp_body == ""
  end

  test "returns a successful response from get order endpoint" do
    Ecto.Adapters.SQL.query!(Playground.Infrastructure.Database.Repo, "DELETE FROM \"order\"", [])

    Ecto.Adapters.SQL.query!(
      Playground.Infrastructure.Database.Repo,
      "DELETE FROM \"order_item\"",
      []
    )

    Repo.insert(%EctoOrder{
      id: Ecto.UUID.cast!("d3c4ca9e-09f1-499f-bab9-bbd57a0698a5"),
      user_id: Ecto.UUID.cast!("85559266-19a6-4027-904d-dd40163f538d"),
      timestamp: DateTime.truncate(~U[2022-01-12 00:01:00Z], :second),
      items: [
        %EctoOrderItem{
          order_id: Ecto.UUID.cast!("d3c4ca9e-09f1-499f-bab9-bbd57a0698a5"),
          row_number: 1,
          description: "Birra",
          qty: 2,
          price_amount_in_mills: 5_000,
          price_currency: "EUR"
        }
      ]
    })

    conn =
      conn(:get, "/api/orders/d3c4ca9e-09f1-499f-bab9-bbd57a0698a5")
      |> put_req_header("accept", "application/json")

    conn = Endpoint.call(conn, @opts)

    assert conn.state == :sent
    assert conn.status == 200
    assert conn.resp_body == ""
  end
end
