defmodule Playground.Domain.OrderRepository do
  alias Playground.Domain.Order

  @callback get(id :: String.t()) :: %Order{}

  @callback store(order :: %Order{}) :: :ok | {:error, String.t()}
end
