defmodule Playground.Infrastructure.Application do
  use Application

  @impl true
  def start(_type, _args) do
    Playground.Infrastructure.Supervisor.start_link()
  end
end
