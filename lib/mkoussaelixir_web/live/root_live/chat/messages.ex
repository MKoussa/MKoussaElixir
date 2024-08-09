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
      <%!-- <div id="infinite-scroll-marker" phx-hook="InfiniteScroll"></div> --%>
      <div
        :for={{dom_id, message} <- @messages}
        id={dom_id}
        phx-hook="Hover"
        data-toggle={JS.toggle(to: "#message-#{message.id}-buttons")}
      >
        <.message_details message={message} current_user_uuid={@current_user_uuid} />
      </div>
    </div>
    """
  end

  def message_details(assigns) do
    ~H"""
    <%= if @message.sender.uuid == @current_user_uuid do %>
      <div class="chat-message-me" style="text-align: right;">
        <.message_meta message={@message} current_user_uuid={@current_user_uuid} />
        <.message_content message={@message} />
      </div>
    <% else %>
      <div class="chat-message-you" style="text-align: left;">
        <.message_meta message={@message} current_user_uuid={@current_user_uuid} />
        <.message_content message={@message} />
      </div>
    <% end %>
    """
  end

  def message_meta(assigns) do
    ~H"""
    <dl>
      <div>
        <dt style="font-weight: 900">
          <span style="font-weight: 300;">
            <%= if @message.sender.uuid == @current_user_uuid do %>
              <span style="font-size: 8px;">
                <time datetime={@message.inserted_at}>
                  <%= @message.inserted_at %>
                </time>
              </span>
              <br />
              <span>You said:</span>
            <% else %>
              <span style="font-size: 8px;">
                <time datetime={@message.inserted_at}>
                  <%= @message.inserted_at %>
                </time>
              </span>
              <br />
              <span><%= @message.sender.public_profile.username %> said:</span>
            <% end %>
          </span>
        </dt>
      </div>
    </dl>
    """
  end

  def message_content(assigns) do
    ~H"""
    <dl>
      <div>
        <dd>
          <%= @message.content %>
        </dd>
      </div>
    </dl>
    """
  end
end
