defmodule MkoussaelixirWeb.CartItemController do
  use MkoussaelixirWeb, :controller

  alias Mkoussaelixir.ShoppingCart

  def create(conn, %{"product_id" => product_id}) do
    case ShoppingCart.add_item_to_cart(conn.assigns.cart, product_id) do
      {:ok, _item} ->
        conn
        |> put_flash(:info, "Item added to your cart!")
        |> redirect(to: ~p"/shop/cart")

      {:error, _changeset} ->
        conn
        |> put_flash(:error, "Error Adding Item to Cart.")
        |> redirect(to: ~p"/shop/cart")
    end
  end

  def delete(conn, %{"id" => product_id}) do
    {:ok, _cart} = ShoppingCart.remove_item_from_cart(conn.assigns.cart, product_id)
    redirect(conn, to: ~p"/shop/cart")
  end
end
