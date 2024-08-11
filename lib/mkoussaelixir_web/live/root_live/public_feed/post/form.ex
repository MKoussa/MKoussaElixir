defmodule MkoussaelixirWeb.RootLive.PublicFeed.Post.Form do
  use MkoussaelixirWeb, :live_component

  alias Mkoussaelixir.Posts
  alias Mkoussaelixir.Posts.Post

  def render(assigns) do
    ~H"""
    <div>
      <.simple_form
        for={@new_post_form}
        id="new_post_form"
        phx-submit="post"
        phx-change="update"
        phx-target={@myself}
      >
        <.input placeholder="Post to Public Feed..." field={@new_post_form[:content]} />
        <:actions>
          <.button>Post</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  def handle_event("update", %{"post" => %{"content" => content}}, socket) do
    {:noreply,
     socket
     |> assign(:changeset, Posts.change_post(%Post{content: content}))}
  end

  def handle_event("post", %{"post" => %{"content" => content}}, socket) do
    Posts.create_post(%{content: content, poster_id: socket.assigns.poster.id})

    {:noreply,
     socket
     |> assign(:changeset, assign_changeset(socket))}
  end

  def update(assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_changeset}
  end

  def assign_changeset(socket) do
    assign(socket, :changeset, Posts.change_post(%Post{}))
  end
end
