defmodule Playground.Infrastructure.UI.Rest.Controller.OrderController do
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
        Playground.Infrastructure.Clock.SystemClock,
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
    order = Playground.Infrastructure.UI.Rest.Repository.OrderRepository.get(order_id)

    case Jason.encode(order) do
      {:ok, encoded_order} ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(200, encoded_order)

      {:error, _} ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(500, "Internal server error")
    end
  end

  def get_list(conn) do
    orders = Playground.Infrastructure.UI.Rest.Repository.OrderRepository.get_list()

    case Jason.encode(orders) do
      {:ok, encoded_orders} ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(200, encoded_orders)

      {:error, _} ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(500, "Internal server error")
    end
  end
end
