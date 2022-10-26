defmodule Playground.Infrastructure.UI.Resource.Order do
  @type t() :: %__MODULE__{
          id: String.t(),
          user_id: String.t(),
          timestamp: %DateTime{},
          items: [order_item_data()]
        }

  @type order_item_data :: %{
          row_number: integer,
          description: String.t(),
          qty: integer,
          price: Playground.Infrastructure.UI.Resource.Money
        }

  @derive Jason.Encoder
  @enforce_keys [:id, :user_id, :timestamp, :items]
  defstruct [:id, :user_id, :timestamp, :items]
end
