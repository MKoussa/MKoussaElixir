defmodule MkoussaelixirWeb.PageLive do
  use MkoussaelixirWeb, :live_view

  alias Mkoussaelixir.Posts
  alias Mkoussaelixir.Posts.Post
  alias MkoussaelixirWeb.Endpoint
  alias Mkoussaelixir.Accounts

  on_mount {MkoussaelixirWeb.UserAuth, :mount_current_user}

  attr :current_user, :string, required: false, default: nil

  def render(assigns) do
    ~H"""
    <div class="root-transition">
      <h2>Welcome, <i>Friend</i></h2>

      <p><i>This</i> is a <b>space</b>.</p>
      <span>
        <span style="vertical-align: 1em;">Welcome to</span>
        <h3>MKOUSSA</h3>
      </span>
      <p>More information in the About</p>
      <.link href="https://weerd.space/">
        <span>
          <span style="vertical-align: 1em;">Looking for</span>
          <span style="font-size: clamp(0.625rem, 3vw, 3.8rem);">
            <span style="font-family: 'Moirai One'; font-size: clamp(0.825rem, 3.3vw, 4.12rem); margin-right: -0.42em;">
              W
            </span>
            <span style="font-family: Righteous;">
              eerd
            </span>
            <span style="font-family: Astloch; margin-left: -0.42em; font-style: italic;">
              Space
            </span>
          </span>?
        </span>
      </.link>
    </div>
    """
  end

  def mount(_, _, socket) do
    if socket.assigns.current_user do
      if connected?(socket), do: Endpoint.subscribe("public_post_feed")
    end

    {:ok, socket}
  end

  def handle_params(_, _, socket) do
    if socket.assigns.current_user do
      new_post_form = Posts.change_post(%Post{})

      {:noreply,
       socket
       |> assign_posts()
       |> assign(:new_post_form, to_form(new_post_form))}
    else
      {:noreply,
       socket
       |> assign(user_count: Accounts.get_user_count())
       |> assign(post_count: Posts.get_post_count())}
    end
  end

  def handle_info(%{event: "post", payload: %{post: post}}, socket) do
    {:noreply,
     socket
     |> insert_new_post(post)}
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
      {:ok, new_post} ->
        post = Posts.get_post!(repost_id)
        poster = Accounts.get_user!(post.poster_id)

        send_update(MkoussaelixirWeb.RootLive.PublicFeed.Posts,
          id: "public-post:#{post.id}",
          post: post,
          liker: socket.assigns.current_user,
          public_profile: Accounts.get_public_profile_by_user_uuid(poster.uuid),
          poster_uuid: poster.uuid
        )

        {:noreply,
         socket
         |> insert_new_post(new_post)}

      {:error, error} ->
        {:noreply,
         socket
         |> put_flash(:error, error)}
    end
  end

  def insert_new_post(socket, post) do
    socket
    |> stream_insert(:posts, Posts.preload_post_sender(post), at: 0)
  end

  def assign_posts(socket) do
    posts = Mkoussaelixir.Posts.last_twenty_public_posts()

    socket
    |> stream(:posts, posts)
  end
end
