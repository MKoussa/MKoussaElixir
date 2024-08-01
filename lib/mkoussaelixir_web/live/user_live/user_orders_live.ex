defmodule MkoussaelixirWeb.UserLive.UserOrdersLive do
  use MkoussaelixirWeb, :live_view

  on_mount {MkoussaelixirWeb.UserAuth, :ensure_authenticated}

  def render(assigns) do
    ~H"""
    <div class="root-transition">
      <.header>
        Your Orders
      </.header>

      <.table id="orders" rows={@orders} row_click={&JS.navigate(~p"/shop/orders/#{&1.id}")}>
        <:col :let={order} label="Order Number"><%= order.id %></:col>
        <:col :let={order} label="Order Date">
          <%= order.inserted_at.month %>-<%= order.inserted_at.day %>-<%= order.inserted_at.year %>
        </:col>
        <:col :let={order} label="Items">
          <.table
            id="order_items"
            rows={order.line_items}
            row_click={&JS.navigate(~p"/shop/products/#{&1.product.id}")}
          >
            <:col :let={line_item} label="Name"><%= line_item.product.title %></:col>
            <:col :let={line_item} label="Price">
              <%= MkoussaelixirWeb.CartHTML.currency_to_str(line_item.price) %>
            </:col>
            <:col :let={line_item} label="Quantity"><%= line_item.quantity %></:col>
          </.table>
        </:col>
        <:col :let={order} label="Order Total">
          <%= MkoussaelixirWeb.CartHTML.currency_to_str(order.total_price) %>
        </:col>
      </.table>
    </div>
    """
  end

  alias Mkoussaelixir.Orders

  def mount(_params, %{"current_user" => current_user}, socket) do
    if is_nil(current_user) do
      redirect(socket, to: ~p"/users/log_in")
      {:ok, socket}
    else
      orders = Orders.get_orders!(current_user.uuid)

      {:ok,
       socket
       |> assign(orders: orders)}
    end
  end
end
