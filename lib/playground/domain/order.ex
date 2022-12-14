defmodule Playground.Domain.Order do
  alias Playground.Domain.Clock

  @type t() :: %__MODULE__{
          id: String.t(),
          user_id: String.t(),
          timestamp: DateTime.t(),
          items: [%Playground.Domain.OrderItem{}]
        }
  @enforce_keys [:id, :user_id, :timestamp, :items]
  defstruct [:id, :user_id, :timestamp, :items]

  @type order_item_data :: %{
          row_number: integer,
          description: String.t(),
          qty: integer,
          price: Playground.Domain.Money
        }

  @spec place(Clock.t(), String.t(), String.t(), [order_item_data]) :: %__MODULE__{}
  def place(clock, id, user_id, items) do
    %__MODULE__{
      id: id,
      user_id: user_id,
      timestamp: clock.now(),
      items: for(i <- items, do: struct(Playground.Domain.OrderItem, i))
    }
  end
end
