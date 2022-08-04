defmodule Playground.Domain.OrderItem do
  @type t() :: %__MODULE__{
          row_number: integer,
          description: String.t(),
          qty: integer,
          price: [%Playground.Domain.Money{}]
        }

  @enforce_keys [:row_number, :description, :qty, :price]

  defstruct [:row_number, :description, :qty, :price]
end
