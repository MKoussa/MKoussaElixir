defmodule MkoussaelixirWeb.ShopLive.IndexProductLive do
  use MkoussaelixirWeb, :live_view

  alias Mkoussaelixir.Accounts.User
  alias Mkoussaelixir.Catalog

  def mount(params, session, socket) do
    products = Catalog.list_products()
    {:ok, assign(socket, products: products, user: socket.assigns.current_user || %User{})}
  end
end
