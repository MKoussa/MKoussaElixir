defmodule MkoussaelixirWeb.CartController do
  use MkoussaelixirWeb, :controller

  alias Mkoussaelixir.ShoppingCart

  def show(conn, _params) do
    render(conn, :show, changeset: ShoppingCart.change_cart(conn.assigns.cart))
  end

  def update(conn, %{"cart" => cart_params}) do
    case ShoppingCart.update_cart(conn.assigns.cart, cart_params) do
      {:ok, _cart} ->
        redirect(conn, to: ~p"/cart")

      {:error, _changeset} ->
        conn
        |> put_flash(:error, "Something went wrong when trying to update your cart!")
        |> redirect(to: ~p"/cart")
    end
  end
end
