defmodule MkoussaelixirWeb.RootLive.Chat.ShowRoomsLive do
  use MkoussaelixirWeb, :live_view

  on_mount {MkoussaelixirWeb.UserAuth, :ensure_authenticated}

  alias Mkoussaelixir.Chat
  alias MkoussaelixirWeb.Endpoint

  def mount(%{"id" => id}, _session, socket) do
    if connected?(socket), do: Endpoint.subscribe("room:#{id}")

    {:ok,
     socket
     |> assign_active_room(id)
     |> assign_active_room_messages()
     |> assign_scrolled_to_top()
     |> assign_last_user_message()}
  end

  def assign_active_room(socket, id) do
    assign(socket, :room, Chat.get_room!(id))
  end

  def assign_active_room_messages(socket) do
    messages = Chat.last_ten_messages_for(socket.assigns.room.id)

    if Enum.any?(messages) do
      socket
      |> stream(:messages, messages)
      |> assign(:oldest_message_id, List.first(messages).id)
    else
      socket
      |> stream(:messages, messages)
    end
  end

  def assign_scrolled_to_top(socket, scrolled_to_top \\ "false") do
    assign(socket, :scrolled_to_top, scrolled_to_top)
  end

  def handle_event("unpin_scrollbar_from_top", _params, socket) do
    {:noreply,
     socket
     |> assign_scrolled_to_top("false")}
  end

  def handle_info(%{event: "new_message", payload: %{message: message}}, socket) do
    {:noreply,
     socket
     |> insert_new_message(message)
     |> assign_last_user_message(message)}
  end

  def insert_new_message(socket, message) do
    socket
    |> stream_insert(:messages, Chat.preload_message_sender(message))
  end

  def delete_message(socket, message_id) do
    message = Chat.get_message!(message_id)
    Chat.delete_message(message)
    stream_delete(socket, :messages, message)
  end

  def assign_last_user_message(%{assigns: %{current_user: current_user}} = socket, message)
      when current_user.id == message.sender_id do
    assign(socket, :message, message)
  end

  def assign_last_user_message(socket, _message) do
    socket
  end

  def assign_last_user_message(%{assigns: %{room: nil}} = socket) do
    assign(socket, :message, %Chat.Message{})
  end

  def assign_last_user_message(%{assigns: %{room: room, current_user: current_user}} = socket) do
    assign(socket, :message, get_last_user_message_for_room(room.id, current_user.id))
  end

  def get_last_user_message_for_room(room_id, current_user_id) do
    Chat.last_user_message_for_room(room_id, current_user_id) || %Chat.Message{}
  end
end
