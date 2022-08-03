defmodule Playground.Infrastructure.SystemClock do
  @behaviour Playground.Domain.Clock

  @impl Playground.Domain.Clock
  def now() do
    {:ok, datetime} = DateTime.now("Etc/UTC")

    datetime
  end
end
