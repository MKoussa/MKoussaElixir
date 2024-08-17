defmodule MkoussaelixirWeb.UserPublicProfileLive do
  use MkoussaelixirWeb, :live_view

  alias Mkoussaelixir.Accounts
  alias Mkoussaelixir.Posts
  alias MkoussaelixirWeb.Endpoint

  def render(assigns) do
    ~H"""
    <div style={"padding: 0.3rem;
                 border: #{@public_profile.public_post_border_size}px #{@public_profile.public_post_border_type} #{@public_profile.public_post_border_color};"}>
      <section>
        <h3><%= @public_profile.username %></h3>
        <div style={"background-color: #{@public_profile.public_post_background_color};
                   color: #{@public_profile.public_post_foreground_color};
                   border: #{@public_profile.public_post_border_size}px #{@public_profile.public_post_border_type} #{@public_profile.public_post_border_color};
                   "}>
          <p style="white-space: pre-line;"><%= @public_profile.bio %></p>
        </div>
      </section>
      <section></section>
      <section>
        <h3><%= @public_profile.username %> Posts</h3>

        <div
          id="posts"
          style="height: calc(70vh - 10rem);
               overflow: scroll;
               padding-left: 1rem;
               padding-right: 1rem;
               border-bottom: 1rem solid var(--base-purple);
               animation: rainbow-border 7.5s linear;
               animation-iteration-count: infinite;"
          phx-update="stream"
        >
          <div :for={{dom_id, post} <- @streams.posts} id={dom_id}>
            <.live_component
              id={"public-post:#{post.id}"}
              module={MkoussaelixirWeb.RootLive.PublicFeed.Posts}
              liker={@current_user}
              post={post}
              poster_uuid={post.poster.uuid}
              public_profile={@public_profile}
              style="margin-bottom: 0.5%;"
            />
          </div>
        </div>
      </section>
    </div>
    """
  end

  def mount(%{"uuid" => uuid}, _, socket) do
    if connected?(socket), do: Endpoint.subscribe("public_post_feed")

    public_profile = Accounts.get_public_profile_by_user_uuid(uuid)

    {:ok,
     socket
     |> assign(:public_profile, public_profile)
     |> assign_posts_by_uuid(uuid)}
  end

  def assign_posts_by_uuid(socket, uuid) do
    posts = Mkoussaelixir.Posts.last_ten_public_posts_by_user_uuid(uuid)

    socket
    |> stream(:posts, posts)
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
      public_profile: socket.assigns.public_profile,
      poster_uuid: poster.uuid
    )

    {:noreply, socket}
  end

  def insert_new_post(socket, post) do
    socket
    |> stream_insert(:posts, Posts.preload_post_sender(post), at: 0)
  end
end
