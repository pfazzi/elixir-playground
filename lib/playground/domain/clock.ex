defmodule Playground.Domain.Clock do
  @callback now() :: %DateTime{}
end
