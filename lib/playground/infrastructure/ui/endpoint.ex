defmodule Playground.Infrastructure.UI.Endpoint do
  use Plug.Router

  plug(Plug.Logger)
  plug(:match)
  plug(Plug.Parsers, parsers: [:json, Absinthe.Plug.Parser], json_decoder: Jason)
  plug(:dispatch)

  forward("/graphql",
    to: Absinthe.Plug,
    init_opts: [schema: Playground.Infrastructure.UI.GraphQL.Schema]
  )

  post("/api/orders", do: Playground.Infrastructure.UI.Rest.Controller.OrderController.post(conn))

  get("/api/orders",
    do: Playground.Infrastructure.UI.Rest.Controller.OrderController.get_list(conn)
  )

  get("/api/orders/:id",
    do: Playground.Infrastructure.UI.Rest.Controller.OrderController.get(conn, id)
  )

  match _ do
    send_resp(conn, 404, "oops")
  end
end
