defmodule Playground.Infrastructure.UI.Rest.Resource.OrderItem do
  @type t :: %{
          row_number: integer,
          description: String.t(),
          qty: integer,
          price: Playground.Infrastructure.UI.Rest.Resource.Money
        }

  @derive Jason.Encoder

  @enforce_keys [:row_number, :description, :qty, :price]

  defstruct [:row_number, :description, :qty, :price]
end
