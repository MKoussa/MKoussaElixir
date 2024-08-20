defmodule MkoussaelixirWeb.RootLive.PublicFeed.Post.Form do
  use MkoussaelixirWeb, :live_component

  alias Mkoussaelixir.Posts
  alias Mkoussaelixir.Posts.{Post, Comment}

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
        <.input placeholder="


    Your thoughts?" field={@new_post_form[:content]} type="post" />
        <:actions>
          <span>
            <.button type="reset" name="reset" style="width: 30%;">Reset</.button>
            <.button style="width: 60%;">Post</.button>
          </span>
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

  def handle_event("update", %{"comment" => %{"content" => content}}, socket) do
    {:noreply,
     socket
     |> assign(:changeset, Posts.comment_changeset(%Comment{content: content}))}
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

  def handle_event("post", %{"comment" => %{"content" => content}}, socket) do
    case Posts.create_comment(%{
           content: content,
           commenter_id: socket.assigns.poster.id,
           post_id: socket.assigns.post_id
         }) do
      {:ok, _} ->
        {:noreply, assign_comment_changeset(socket)}

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
     |> assign_comment_changeset()
     |> assign_changeset()}
  end

  def assign_changeset(socket) do
    assign(socket, :changeset, Posts.change_post(%Post{}))
  end

  def assign_comment_changeset(socket) do
    assign(socket, :changeset, Posts.comment_changeset(%Comment{}))
  end
end
