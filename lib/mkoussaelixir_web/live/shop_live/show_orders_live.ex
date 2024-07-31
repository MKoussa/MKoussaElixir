defmodule MkoussaelixirWeb.ShopLive.ShowOrdersLive do
  use MkoussaelixirWeb, :live_view

  alias Mkoussaelixir.Orders

  def mount(%{"id" => id}, %{"current_uuid" => current_uuid}, socket) do
    order = Orders.get_order!(current_uuid, id)

    {:ok,
     socket
     |> assign(page_title: "Order")
     |> assign(order: order)}
  end
end
