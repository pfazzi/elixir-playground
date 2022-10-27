defmodule Playground.Infrastructure.UI.GraphQL.Resolvers.Order do
  alias Playground.Infrastructure.Database.Repo
  import Ecto.Query

  def list_orders(_parent, _args, _resolution) do
    {:ok, Repo.all(from(o in Playground.Infrastructure.Database.Order)) |> Repo.preload(:items)}
  end

  def find_order(_parent, %{id: id}, _resolution) do
    case Repo.get(Playground.Infrastructure.Database.Order, id) |> Repo.preload(:items) do
      nil ->
        {:error, "Order ID #{id} not found"}

      order ->
        {:ok, order}
    end
  end
end
