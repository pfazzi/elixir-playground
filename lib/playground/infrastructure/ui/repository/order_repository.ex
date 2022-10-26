defmodule Playground.Infrastructure.UI.Repository.OrderRepository do
  alias Playground.Infrastructure.Database.Repo

  import Ecto.Query

  @spec get(String.t()) :: Playground.Infrastructure.UI.Resource.Order.t()
  def get(id) do
    Repo.get(Playground.Infrastructure.Database.Order, id)
    |> Repo.preload(:items)
    |> build_view_model()
  end

  @spec get_list() :: [Playground.Infrastructure.UI.Resource.Order.t()]
  def get_list() do
    Repo.all(from(o in Playground.Infrastructure.Database.Order))
    |> Repo.preload(:items)
    |> Enum.map(&build_view_model/1)
  end

  defp build_view_model(order) do
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
