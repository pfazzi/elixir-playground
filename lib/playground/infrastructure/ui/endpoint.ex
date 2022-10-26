defmodule Playground.Infrastructure.UI.Endpoint do
  use Plug.Router

  plug(Plug.Logger)
  plug(:match)
  plug(Plug.Parsers, parsers: [:json], json_decoder: Jason)
  plug(:dispatch)

  post("/api/orders", do: Playground.Infrastructure.UI.Controller.OrderController.post(conn))
  get("/api/orders", do: Playground.Infrastructure.UI.Controller.OrderController.get_list(conn))

  get("/api/orders/:id", do: Playground.Infrastructure.UI.Controller.OrderController.get(conn, id))

  match _ do
    send_resp(conn, 404, "oops")
  end
end
