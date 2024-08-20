defmodule MkoussaelixirWeb.RootLive.Post.Comments do
  use MkoussaelixirWeb, :live_component

  alias MkoussaelixirWeb.Endpoint

  def update(assigns, socket) do
    if connected?(socket), do: Endpoint.subscribe("post-comment:#{assigns.comment.id}")

    {:ok,
     socket
     |> assign(assigns)}
  end

  def render(assigns) do
    ~H"""
    <div
      class="root-transition"
      style={"display: block;
              margin: 1%;
              padding: 1%;
              word-break: break-word;
              background-color: #{@commenter_public_profile.public_post_background_color};
              color: #{@commenter_public_profile.public_post_foreground_color};"}
    >
      <time
        datetime={@comment.inserted_at}
        style="float: right; font-size: clamp(0.3rem, 0.5em, 1rem);"
      >
        <%= Calendar.strftime(@comment.inserted_at, "%m-%d-%y %I:%M %P %Z") %>
      </time>
      <span style="display: block; float: left;">
        <.link patch={~p"/users/public_profile/#{@poster_uuid}"}>
          <%= @commenter_public_profile.username %>
        </.link>
      </span>
      <br />
      <%= @comment.content %>
    </div>
    """
  end
end
