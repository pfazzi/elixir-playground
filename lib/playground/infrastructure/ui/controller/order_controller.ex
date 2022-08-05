defmodule Playground.Infrastructure.UI.Controller.OrderController do
  import Plug.Conn

  def init(options) do
    options
  end

  def post(conn) do
    command = %Playground.Application.PlaceOrder{
      id: conn.body_params["id"],
      user_id: conn.body_params["user_id"],
      items: conn.body_params["items"]
    }

    result =
      Playground.Application.PlaceOrder.execute(
        command,
        Playground.Infrastructure.SystemClock,
        Playground.Infrastructure.Database.EctoOrderRepository
      )

    case result do
      :ok ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(201, "")

      {:error, message} ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(404, Jason.encode!(%{"success" => false, "message" => message}))
    end
  end

  def get(conn, order_id) do
    order = Playground.Infrastructure.UI.Repository.OrderRepository.get(order_id)

    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, Jason.encode!(order))
  end
end
