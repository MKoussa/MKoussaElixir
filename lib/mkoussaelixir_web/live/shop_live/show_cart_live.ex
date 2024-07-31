defmodule MkoussaelixirWeb.ShopLive.ShowCartLive do
  use MkoussaelixirWeb, :live_view

  alias Mkoussaelixir.ShoppingCart

  def mount(_params, %{"current_uuid" => current_uuid}, socket) do
    # if is_nil(socket.assigns.current_user) do
    #   if cart = ShoppingCart.get_cart_by_user_uuid(socket.assigns.current_uuid) do
    #     {:ok,
    #      socket
    #      |> assign(:cart, cart)
    #      |> assign(changeset: ShoppingCart.change_cart(cart))}
    #   else
    #     {:ok, new_cart} = ShoppingCart.create_cart(socket.assigns.current_uuid)

    #     {:ok,
    #      socket
    #      |> assign(:cart, new_cart)
    #      |> assign(changeset: ShoppingCart.change_cart(new_cart))}
    #   end
    # else
    IO.inspect(socket)

    if cart = ShoppingCart.get_cart_by_user_uuid(current_uuid) do
      {:ok,
       socket
       |> assign(:cart, cart)
       |> assign(changeset: ShoppingCart.change_cart(cart))}
    else
      {:ok, new_cart} = ShoppingCart.create_cart(current_uuid)

      {:ok,
       socket
       |> assign(:cart, new_cart)
       |> assign(changeset: ShoppingCart.change_cart(new_cart))}
    end

    # end
  end

  def currency_to_str(%Decimal{} = val) do
    "$#{Decimal.round(val, 2)}"
  end
end
