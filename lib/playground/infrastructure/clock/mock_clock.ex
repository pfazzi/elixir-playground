defmodule Playground.Infrastructure.Clock.MockClock do
  def with_now(now) do
    %{now: now}
  end
end
