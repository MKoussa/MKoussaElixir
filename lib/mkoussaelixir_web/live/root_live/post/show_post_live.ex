defmodule MkoussaelixirWeb.RootLive.Post.ShowPostLive do
  use MkoussaelixirWeb, :live_view

  alias MkoussaelixirWeb.Endpoint
  alias Mkoussaelixir.{Posts.Like, Posts.Post, Posts}
  alias Mkoussaelixir.Accounts

  def mount(%{"id" => id}, _session, socket) do
    if connected?(socket), do: Endpoint.subscribe("post:#{id}")

    post = Mkoussaelixir.Posts.get_post_and_poster!(id)

    {:ok,
     socket
     |> assign(post: post)}
  end

  def render(assigns) do
    ~H"""
    <h3>Post #<%= @post.id %></h3>
    <h4>
      Posted on
      <time datetime={@post.inserted_at}>
        <%= Calendar.strftime(@post.inserted_at, "%A, %B %d %Y at %I:%M %P") %>
      </time>
    </h4>
    <.live_component
      id={"public-post:#{@post.id}"}
      module={MkoussaelixirWeb.RootLive.PublicFeed.Posts}
      liker={@current_user}
      repost_id={@post.repost_id}
      post={@post}
      poster_uuid={@post.poster.uuid}
      public_profile={@post.poster.public_profile}
      style="margin-bottom: 0.5%;"
    /> ---------------------------- <br />
    <.live_component
      module={MkoussaelixirWeb.RootLive.PublicFeed.Post.Form}
      poster={@current_user}
      new_post_form={@new_post_form}
      id="public-post-form"
    />
    """
  end

  def handle_info(%{event: "like", payload: %{like: like}}, socket) do
    post = Posts.get_post!(like.post_id)
    poster = Accounts.get_user!(post.poster_id)

    send_update(MkoussaelixirWeb.RootLive.PublicFeed.Posts,
      id: "public-post:#{like.post_id}",
      post: post,
      liker: socket.assigns.current_user,
      public_profile: Accounts.get_public_profile_by_user_uuid(poster.uuid),
      poster_uuid: poster.uuid
    )

    {:noreply, socket}
  end

  def handle_event("flip", %{"repost_id" => repost_id}, socket) do
    case Posts.create_post(%{
           poster_id: socket.assigns.current_user.id,
           content: "Repost",
           repost_id: String.to_integer(repost_id)
         }) do
      {:ok, _} ->
        {:noreply,
         socket
         |> put_flash(:info, "Repost Successful!")}

      {:error, error} ->
        {:noreply,
         socket
         |> put_flash(:error, error)}
    end
  end
end
