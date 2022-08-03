defmodule Playground.Domain.OrderItem do
  @type t() :: %__MODULE__{
          description: String.t(),
          qty: integer,
          price: [%Playground.Domain.Money{}]
        }

  @enforce_keys [:description, :qty, :price]

  defstruct [:description, :qty, :price]
end
