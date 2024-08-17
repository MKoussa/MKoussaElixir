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
              padding: 1%;
              word-break: break-word;
              background-color: #{@public_profile.public_post_background_color};
              color: #{@public_profile.public_post_foreground_color};
              border: #{@public_profile.public_post_border_size}px #{@public_profile.public_post_border_type} #{@public_profile.public_post_border_color};"}
    >
      <span>
        <%= @post.inserted_at %>,
        <strong>
          <.link patch={~p"/users/public_profile/#{@poster_uuid}"}>
            <%= @public_profile.username %>
          </.link>
        </strong>
        :
      </span>
      <p style="white-space: pre-line;"><%= @post.content %></p>
      <%= if @poster_uuid == @liker.uuid or Posts.already_liked?(@post, @liker) do %>
        <span>
          <div style={"background-color: ##{ Posts.average_like_color(@post) };
                       text-align: left;
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
          style={"border: #{@public_profile.public_post_border_size}px #{@public_profile.public_post_border_type} #{@public_profile.public_post_border_color};"}
        >
          <.input
            label="vibe check"
            id={"color-vibe-check:#{@post.id }"}
            name="color-vibe-check"
            type="boop"
            field={f[:like_color]}
          />
          <:actions>
            <.button>Boop</.button>
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
     |> assign(assigns)
     |> assign_changeset()}
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
