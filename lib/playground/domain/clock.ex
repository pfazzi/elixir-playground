defmodule Playground.Domain.Clock do
  @type t :: module()

  @callback now() :: DateTime.t()
end
