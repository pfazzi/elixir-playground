defmodule Playground.Infrastructure.UI.Rest.Resource.Order do
  @type t() :: %__MODULE__{
          id: String.t(),
          user_id: String.t(),
          timestamp: %DateTime{},
          items: [Playground.Infrastructure.UI.Rest.Resource.Order.t()]
        }

  @derive Jason.Encoder
  @enforce_keys [:id, :user_id, :timestamp, :items]
  defstruct [:id, :user_id, :timestamp, :items]
end
