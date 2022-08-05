defmodule Playground.Infrastructure.UI.Repository.OrderRepository do
  def get(id) do
    order =
      Playground.Infrastructure.Database.Repo.get(Playground.Infrastructure.Database.Order, id)
      |> Playground.Infrastructure.Database.Repo.preload(:items)

    order = struct(Playground.Infrastructure.UI.Resource.Order, Map.from_struct(order))

    items =
      Enum.map(order.items, fn i ->
        %Playground.Infrastructure.UI.Resource.OrderItem{
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
end
