defmodule MkoussaelixirWeb.ChatLive.Messages do
  use MkoussaelixirWeb, :html

  def list_messages(assigns) do
    ~H"""
    <div
      id="messages"
      phx-update="stream"
      style="height: calc(60vh - 10rem); overflow: scroll;"
      phx-hook="ScrollDown"
      data-scrolled-to-top={@scrolled_to_top}
    >
      <div
        :for={{dom_id, message} <- @messages}
        id={dom_id}
        phx-hook="Hover"
        data-toggle={JS.toggle(to: "#message-#{message.id}-buttons")}
      >
        <.message_details
          message={message}
          current_user_uuid={@current_user_uuid}
          background_color_me={@background_color_me}
          foreground_color_me={@foreground_color_me}
          background_color_them={@background_color_them}
          foreground_color_them={@foreground_color_them}
        />
      </div>
    </div>
    """
  end

  def message_details(assigns) do
    ~H"""
    <%= if @message.sender.uuid == @current_user_uuid do %>
      <div
        class="chat-message-me"
        style={"text-align: right; background-color: #{@background_color_me}; color: #{@foreground_color_me};"}
      >
        <.message_meta message={@message} me?={true} /><.message_content message={@message} />
      </div>
    <% else %>
      <div
        class="chat-message-them"
        style={"text-align: left; background-color: #{@background_color_them}; color: #{@foreground_color_them};"}
      >
        <.message_meta message={@message} me?={false} />
        <.message_content message={@message} />
      </div>
    <% end %>
    """
  end

  def message_meta(assigns) do
    ~H"""
    <time datetime={@message.inserted_at} style="font-size: 8px;">
      <%= @message.inserted_at %>
    </time>
    <br />
    <.link patch={~p"/users/public_profile/#{@message.sender.uuid}"}>
      <%= if @me? do %>
        You
      <% else %>
        <%= @message.sender.public_profile.username %>
      <% end %>
    </.link>
    said:
    """
  end

  def message_content(assigns) do
    ~H"""
    <p style="word-break: break-word; white-space: pre-wrap;">
      <%= @message.content %>
    </p>
    """
  end
end
