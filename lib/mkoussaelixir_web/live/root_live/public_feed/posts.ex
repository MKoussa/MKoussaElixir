defmodule MkoussaelixirWeb.RootLive.PublicFeed.Posts do
  use MkoussaelixirWeb, :live_component

  alias Mkoussaelixir.Posts.Like
  alias Mkoussaelixir.Posts
  alias MkoussaelixirWeb.Endpoint

  def render(assigns) do
    ~H"""
    <div
      class="root-transition"
      style={"display: block;
              margin: 1%;
              padding: 0.2rem;
              word-break: break-word;
              background-color: #{@public_profile.public_post_background_color};
              color: #{@public_profile.public_post_foreground_color};
              border: #{@public_profile.public_post_border_size}px #{@public_profile.public_post_border_type} #{@public_profile.public_post_border_color};"}
    >
      <span style="display: block;">
        <%= if @poster_uuid != @liker.uuid and !@repost_id and @show_repost_bubble and !Posts.already_reposted?(@post, @liker) do %>
          <.button
            phx-click="flip"
            phx-value-repost_id={@post.id}
            style={"float: left;
                    border: 0;
                    border-radius: 20%;
                    font-size: clamp(0.7rem, 3em, 6rem);
                    color: #{@public_profile.public_post_foreground_color};
                    background-color: #{@public_profile.public_post_background_color};
                    mix-blend-mode: normal;"}
          >
            &#9853;
          </.button>
        <% end %>

        <b>
          <.link patch={~p"/users/public_profile/#{@poster_uuid}"}>
            <%= @public_profile.username %>
          </.link>
        </b>
        :
        <%= if !@repost_id and @show_comment_bubble do %>
          <.link patch={~p"/posts/#{@post.id}"}>
            <.button style={"float: right;
                          border: 0;
                          border-radius: 20%;
                          font-size: clamp(0.7rem, 3em, 6rem);
                          background-color: #{@public_profile.public_post_background_color};
                          mix-blend-mode: normal;
                          width: clamp(2rem, 3.5vw, 9rem);
                          height: clamp(2rem, 3.5vw, 9rem);
                          margin: 1%;
                          "}>
              <svg
                class="nav-button-svg"
                aria-hidden="true"
                xmlns="http://www.w3.org/2000/svg"
                viewBox="0 0 24 24"
                style="animation: none;
                       mix-blend-mode: normal;
                       "
              >
                <path
                  stroke={"#{@public_profile.public_post_foreground_color}"}
                  fill={"#{@public_profile.public_post_background_color}"}
                  stroke-linecap="round"
                  stroke-linejoin="round"
                  stroke-width="2"
                  d="M9 17h6l3 3v-3h2V9h-2M4 4h11v8H9l-3 3v-3H4V4Z"
                />
              </svg>
            </.button>
          </.link>
        <% end %>
      </span>
      <%= if @repost_id do %>
        <h3 style="animation: rainbow-color 2.5s linear; animation-iteration-count: infinite;">
          _~♥ REPOST ♥~_
        </h3>
        <div
          class="root-transition"
          style={"display: block;
              margin: 1%;
              padding: 1%;
              word-break: break-word;
              background-color: #{@repost.poster.public_profile.public_post_background_color};
              color: #{@repost.poster.public_profile.public_post_foreground_color};
              border: #{@repost.poster.public_profile.public_post_border_size}px #{@repost.poster.public_profile.public_post_border_type} #{@repost.poster.public_profile.public_post_border_color};"}
        >
          <span>
            <strong>
              <.link patch={~p"/users/public_profile/#{@repost.poster.uuid}"}>
                <%= @repost.poster.public_profile.username %>
              </.link>
            </strong>
            :
            <.link patch={~p"/posts/#{@repost.id}"}>
              <.button style={"float: right;
                          border: 0;
                          border-radius: 20%;
                          font-size: clamp(0.7rem, 3em, 6rem);
                          background-color: #{@repost.poster.public_profile.public_post_background_color};
                          mix-blend-mode: normal;
                          width: clamp(2rem, 3.5vw, 9rem);
                          height: clamp(2rem, 3.5vw, 9rem);
                          "}>
                <svg
                  class="nav-button-svg"
                  aria-hidden="true"
                  xmlns="http://www.w3.org/2000/svg"
                  viewBox="0 0 24 24"
                  style="animation: none;
                       mix-blend-mode: normal;
                       "
                >
                  <path
                    stroke={"#{@repost.poster.public_profile.public_post_foreground_color}"}
                    fill={"#{@repost.poster.public_profile.public_post_background_color}"}
                    stroke-linecap="round"
                    stroke-linejoin="round"
                    stroke-width="2"
                    d="M9 17h6l3 3v-3h2V9h-2M4 4h11v8H9l-3 3v-3H4V4Z"
                  />
                </svg>
              </.button>
            </.link>
          </span>
          <p style="white-space: pre-line;"><%= @repost.content %></p>
          <span>
            <div style={"background-color: ##{Posts.average_like_color(@repost)};
                       text-align: left;
                       border: #{@repost.poster.public_profile.public_post_border_size}px #{@repost.poster.public_profile.public_post_border_type} #{@repost.poster.public_profile.public_post_border_color};"
                       }>
              <span style="filter: invert(1);">
                Boops: <%= Posts.like_count(@repost) %>
              </span>
            </div>
          </span>
        </div>
      <% else %>
        <span style="display: block;">
          <p style="white-space: pre-line;"><%= @post.content %></p>
        </span>
        <br />
      <% end %>
      <%= if @poster_uuid == @liker.uuid or Posts.already_liked?(@post, @liker) do %>
        <span>
          <div style={"background-color: ##{ Posts.average_like_color(@post) };
                       text-align: right;
                       border: #{@public_profile.public_post_border_size}px #{@public_profile.public_post_border_type} #{@public_profile.public_post_border_color};"
                       }>
            <span style="filter: invert(1);">
              Boops: <%= Posts.like_count(@post) %>
            </span>
          </div>
        </span>
      <% else %>
        <.simple_form
          :let={f}
          type="boop"
          for={@changeset}
          phx-submit="submit-like"
          phx-target={@myself}
          style={"border: #{@public_profile.public_post_border_size}px #{@public_profile.public_post_border_type} #{@public_profile.public_post_border_color};
                    padding: 0.3rem;
                    display: flow-root;"}
        >
          <.input
            label="vibe check"
            id={"color-vibe-check:#{@post.id }"}
            name="color-vibe-check"
            type="boop"
            field={f[:like_color]}
            style="float: left;
              width: 70%;"
          />
          <:actions>
            <.button style={"background-color: #{@public_profile.public_post_foreground_color};
                        color: #{@public_profile.public_post_background_color};
                        border: clamp(0.1rem, 0.5em, 1rem) outset;
                        border-color: #{@public_profile.public_post_foreground_color};
                        mix-blend-mode: normal;
                        float: right;"}>
              Boop
            </.button>
          </:actions>
        </.simple_form>
      <% end %>
    </div>
    """
  end

  def update(assigns, socket) do
    if connected?(socket), do: Endpoint.subscribe("post:#{assigns.post.id}")

    {:ok,
     socket
     |> assign_repost(assigns)
     |> assign(assigns)
     |> assign_changeset()}
  end

  def assign_repost(socket, assigns) do
    if assigns.post.repost_id do
      assign(socket, repost: Posts.get_repost!(assigns.post.repost_id))
    else
      socket
    end
  end

  def handle_event("submit-like", %{"color-vibe-check" => color}, socket) do
    case Posts.create_like(%{
           like_color: color,
           liker_id: socket.assigns.liker.id,
           post_id: socket.assigns.post.id
         }) do
      {:ok, _} ->
        {:noreply, assign_changeset(socket)}

      {:error, error} ->
        {:noreply,
         socket
         |> put_flash(:error, error)}
    end
  end

  def assign_changeset(socket) do
    assign(socket, :changeset, Posts.like_changeset(%Like{}))
  end
end
