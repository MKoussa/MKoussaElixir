defmodule MkoussaelixirWeb.RootLive.PublicFeed.Post.Form do
  use MkoussaelixirWeb, :live_component

  alias Mkoussaelixir.Posts
  alias Mkoussaelixir.Posts.Post

  def render(assigns) do
    ~H"""
    <span>
      <.simple_form
        for={@changeset}
        id="new_post_form"
        phx-submit="post"
        phx-change="update"
        phx-target={@myself}
      >
        <.input placeholder="Post to Public Feed..." field={@new_post_form[:content]} type="post" />
        <:actions>
          <.button style="width: 80%;">Post</.button>
        </:actions>
      </.simple_form>
    </span>
    """
  end

  def handle_event("update", %{"post" => %{"content" => content}}, socket) do
    {:noreply,
     socket
     |> assign(:changeset, Posts.change_post(%Post{content: content}))}
  end

  def handle_event("post", %{"post" => %{"content" => content}}, socket) do
    case Posts.create_post(%{content: content, poster_id: socket.assigns.poster.id}) do
      {:ok, _} ->
        {:noreply, assign_changeset(socket)}

      {:error, error} ->
        {:noreply,
         socket
         |> put_flash(:error, error)}
    end
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
