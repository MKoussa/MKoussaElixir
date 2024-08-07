defmodule MkoussaelixirWeb.ShopLive.IndexProductLive do
  use MkoussaelixirWeb, :live_view

  alias Mkoussaelixir.Catalog

  def mount(_params, _session, socket) do
    products = Catalog.list_products()
    # {:ok, assign(socket, products: products, user: socket.assigns.current_user || %User{})}

    {:ok,
     socket
     |> assign(page_title: "Products")
     |> assign(products: products)}
  end
end
