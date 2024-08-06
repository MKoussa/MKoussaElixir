defmodule MkoussaelixirWeb.RootLive.Chat.IndexRoomsLive do
  use MkoussaelixirWeb, :live_view
  on_mount {MkoussaelixirWeb.UserAuth, :ensure_authenticated}

  alias Mkoussaelixir.Chat

  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign_rooms()}
  end

  def handle_event("new_room", _, socket) do
    Chat.create_room(%{name: "test", description: "descip"})

    {:noreply,
     socket
     |> assign(:rooms, Chat.list_rooms())}
  end

  def handle_event("delete_room", %{"room_id" => room_id}, socket) do
    Chat.delete_room_by_id(room_id)

    {:noreply,
     socket
     |> assign(:rooms, Chat.list_rooms())}
  end

  def assign_rooms(socket) do
    assign(socket, :rooms, Chat.list_rooms())
  end
end
