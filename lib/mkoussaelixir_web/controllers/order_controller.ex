defmodule MkoussaelixirWeb.OrderController do
  use MkoussaelixirWeb, :controller

  alias Mkoussaelixir.Orders

  def create(conn, _) do
    case Orders.complete_order(conn.assigns.cart) do
      {:ok, order} ->
        conn
        |> put_flash(:info, "Order Created Successfully!")
        |> redirect(to: ~p"/shop/orders/#{order}")

      {:error, _reason} ->
        conn
        |> put_flash(:error, "Oh No! There was an error processing your order!")
        |> redirect(to: ~p"/shop/cart")
    end
  end

  def show(conn, %{"id" => id}) do
    order = Orders.get_order!(conn.assigns.current_uuid, id)
    render(conn, :show, order: order)
  end
end
