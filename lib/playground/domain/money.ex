defmodule Playground.Domain.Money do
  @derive Jason.Encoder

  @type t() :: %__MODULE__{
          amount_in_mills: integer,
          currency: String.t()
        }

  @enforce_keys [:amount_in_mills]

  defstruct [:amount_in_mills, currency: "EUR"]
end
