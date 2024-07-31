defmodule MkoussaelixirWeb.ShopLive.ShowProductLive do
  alias MkoussaelixirWeb.ShopLive
  use MkoussaelixirWeb, :live_view

  alias Mkoussaelixir.Catalog
  alias Mkoussaelixir.ShoppingCart

  def mount(%{"id" => id}, %{"current_uuid" => current_uuid}, socket) do
    IO.inspect(socket)

    socket =
      if cart = ShoppingCart.get_cart_by_user_uuid(current_uuid) do
        assign(socket, :cart, cart)
      else
        {:ok, new_cart} = ShoppingCart.create_cart(current_uuid)
        assign(socket, :cart, new_cart)
      end

    product =
      id
      |> Catalog.get_product!()
      |> Catalog.inc_page_views()

    {:ok,
     socket
     |> assign(product: product)}

    #  |> assign(cart: cart)}
  end

  def handle_event("put_into_cart", _params, socket) do
    IO.inspect(socket)

    case ShoppingCart.add_item_to_cart(socket.assigns.cart, socket.assigns.product.id) do
      {:ok, _item} ->
        IO.inspect(socket)

        {:noreply,
         socket
         |> put_flash(:info, "Item added to your cart!")
         |> push_navigate(to: ~p"/shop/cart")}

      {:error, _changeset} ->
        {:noreply,
         socket
         |> put_flash(:error, "Error Adding Item to Cart.")
         |> push_navigate(to: ~p"/shop/cart")}
    end
  end
end
