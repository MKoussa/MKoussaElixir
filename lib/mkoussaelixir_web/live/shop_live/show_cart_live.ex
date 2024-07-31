defmodule MkoussaelixirWeb.ShopLive.ShowCartLive do
  use MkoussaelixirWeb, :live_view

  alias Mkoussaelixir.ShoppingCart

  def mount(_params, %{"current_uuid" => current_uuid}, socket) do
    if cart = ShoppingCart.get_cart_by_user_uuid(current_uuid) do
      {:ok,
       socket
       |> assign(:cart, cart)
       |> assign(page_title: "Cart")
       |> assign(changeset: ShoppingCart.change_cart(cart))}
    else
      {:ok, new_cart} = ShoppingCart.create_cart(current_uuid)

      {:ok,
       socket
       |> assign(:cart, new_cart)
       |> assign(page_title: "Cart")
       |> assign(changeset: ShoppingCart.change_cart(new_cart))}
    end

    # end
  end

  def handle_event("update_cart", %{"cart" => cart_params}, socket) do
    case ShoppingCart.update_cart(socket.assigns.cart, cart_params) do
      {:ok, _cart} ->
        {:noreply,
         socket
         |> put_flash(:info, "Cart Updated!")
         |> push_navigate(to: ~p"/shop/cart")}

      {:error, _changeset} ->
        {:noreply,
         socket
         |> put_flash(:error, "Something went wrong when trying to update your cart!")
         |> push_navigate(to: ~p"/shop/cart")}
    end
  end

  alias Mkoussaelixir.Orders

  def handle_event("complete_order", _params, socket) do
    case Orders.complete_order(socket.assigns.cart) do
      {:ok, order} ->
        {:noreply,
         socket
         |> put_flash(:info, "Order Created Successfully!")
         |> push_navigate(to: ~p"/shop/orders/#{order}")}

      {:error, _reason} ->
        {:noreply,
         socket
         |> put_flash(:error, "Oh No! There was an error processing your order!")
         |> push_navigate(to: ~p"/shop/cart")}
    end
  end

  def currency_to_str(%Decimal{} = val) do
    "$#{Decimal.round(val, 2)}"
  end
end
