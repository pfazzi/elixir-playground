defmodule Playground.Infrastructure.Database.EctoOrderRepository do
  use Ecto.Repo,
    otp_app: :playground,
    adapter: Ecto.Adapters.Postgres

  alias Playground.Infrastructure.Database.Order, as: EctoOrder
  alias Playground.Infrastructure.Database.OrderItem, as: EctoOrderItem
  alias Playground.Domain.OrderItem, as: DomainOrderItem

  @behaviour Playground.Domain.OrderRepository

  @impl Playground.Domain.OrderRepository
  def get(id) do
    order =
      Playground.Infrastructure.Database.Repo.get(Playground.Infrastructure.Database.Order, id)
      |> Playground.Infrastructure.Database.Repo.preload(:items)

    order = struct(Playground.Domain.Order, Map.from_struct(order))

    items =
      Enum.map(order.items, fn i ->
        %DomainOrderItem{
          row_number: i.row_number,
          description: i.description,
          qty: i.qty,
          price: %Playground.Domain.Money{
            amount_in_mills: i.price_amount_in_mills,
            currency: i.price_currency
          }
        }
      end)

    %{order | items: items}
  end

  @impl Playground.Domain.OrderRepository
  def store(order) do
    case {Ecto.UUID.cast(order.id), Ecto.UUID.cast(order.user_id)} do
      {{:ok, order_id}, {:ok, user_id}} ->
        ecto_order = %EctoOrder{
          id: order_id,
          user_id: user_id,
          timestamp: DateTime.truncate(order.timestamp, :second),
          items:
            Enum.map(order.items, fn i ->
              %EctoOrderItem{
                order_id: order_id,
                row_number: i.row_number,
                description: i.description,
                qty: i.qty,
                price_amount_in_mills: i.price.amount_in_mills,
                price_currency: i.price.currency
              }
            end)
        }

        case Playground.Infrastructure.Database.Repo.insert(ecto_order) do
          {:ok, _} -> :ok
          {:error, _} -> {:error, "Error while storing order"}
        end

      {:error, _} ->
        {:error, "Unable to parse the given order id"}

      {_, :error} ->
        {:error, "Unable to parse the given user id"}
    end
  end
end
