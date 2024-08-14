defmodule MkoussaelixirWeb.ChatLive.Message.Form do
  use MkoussaelixirWeb, :live_component
  import MkoussaelixirWeb.CoreComponents
  alias Mkoussaelixir.Chat
  alias Mkoussaelixir.Chat.Message

  def render(assigns) do
    ~H"""
    <div>
      <.simple_form
        :let={f}
        for={@changeset}
        phx-submit="save"
        phx-change="update"
        phx-target={@myself}
      >
        <.input
          autocomplete="off"
          phx-keydown={show_modal("edit_message")}
          phx-key="ArrowUp"
          phx-focus="unpin_scrollbar_from_top"
          placeholder="Say your peace..."
          field={{f, :content}}
        />
        <:actions>
          <.button>Send</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  def handle_event("update", %{"message" => %{"content" => content}}, socket) do
    {:noreply,
     socket
     |> assign(:changeset, Chat.change_message(%Message{content: content}))}
  end

  def handle_event("save", %{"message" => %{"content" => content}}, socket) do
    last_message = Chat.last_message_for_room(socket.assigns.room_id)

    if last_message && last_message.sender_id == socket.assigns.sender_id &&
         String.length(last_message.content <> content) < 250 do
      Chat.update_message(last_message, %{content: "#{last_message.content}\n#{content}"})
    else
      Chat.create_message(%{
        content: content,
        room_id: socket.assigns.room_id,
        sender_id: socket.assigns.sender_id
      })
    end

    {:noreply, assign_changeset(socket)}
  end

  def update(assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_changeset}
  end

  def assign_changeset(socket) do
    assign(socket, :changeset, Chat.change_message(%Message{}))
  end
end
