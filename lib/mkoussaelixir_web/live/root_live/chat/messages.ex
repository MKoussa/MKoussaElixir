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
              <%= @message.inserted_at.year %> you said:
            <% else %>
              <%= @message.inserted_at.year %> <%= String.slice(@message.sender.uuid, 1..4) %> said:
            <% end %>
          </span>
        </dt>
      </div>
    </dl>
    """
  end

  def message_content(assigns) do
    ~H"""
    <dl class="-my-4 divide-y divide-zinc-100">
      <div class="flex gap-4 py-4 sm:gap-2">
        <dd style="margin-left: 3%;margin-top: -1%; white-space: pre-line;">
          <%= @message.content %>
        </dd>
      </div>
    </dl>
    """
  end
end
