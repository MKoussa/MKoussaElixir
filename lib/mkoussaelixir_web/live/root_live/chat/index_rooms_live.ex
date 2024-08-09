defmodule MkoussaelixirWeb.RootLive.Chat.IndexRoomsLive do
  use MkoussaelixirWeb, :live_view
  on_mount {MkoussaelixirWeb.UserAuth, :ensure_authenticated}

  alias Mkoussaelixir.Chat
  alias Mkoussaelixir.Chat.Room

  def mount(_params, _session, socket) do
    new_room_changeset = Chat.change_room(%Room{})

    {:ok,
     socket
     |> assign_rooms()
     |> assign(:new_room_form, to_form(new_room_changeset))}
    |> IO.inspect()
  end

  def handle_event("new_room", %{"name" => name, "description" => description}, socket) do
    Chat.create_room(%{name: name, description: description})

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

  def handle_event("join_room", %{"room_id" => room_id}, socket) do
    {:noreply, push_navigate(socket, to: "/chat/rooms/#{room_id}")}
  end

  def assign_rooms(socket) do
    assign(socket, :rooms, Chat.list_rooms())
  end
end
