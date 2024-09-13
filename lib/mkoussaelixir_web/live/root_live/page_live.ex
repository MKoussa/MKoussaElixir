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
      <%= if @current_user do %>
        <%= if @current_user.confirmed_at do %>
          <p style="font-family: Astloch; font-size: clamp(0.825rem, 3.6vw, 4.12rem); margin-top: clamp(-0.975rem, -4vw, -11.12rem); margin-bottom: clamp(-0.225rem, -2.6vw, -10.12rem);">
            Public
            <i style="font-family: 'Moirai One'; margin-right: -0.42em; font-size: clamp(1.025rem, 4.6vw, 4.12rem)">
              F
            </i>
            <i style="font-family: Righteous;">eeeeeeed</i>
          </p>
          <section class="chat-room">
            <div
              id="posts"
              style="height: calc(70vh - 10rem);
                     overflow-y: scroll;
                     overflow-x: hidden;
                     padding-left: 0.2rem;
                     padding-right: 0.2rem;
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
                  repost_id={post.repost_id}
                  show_comment_bubble={true}
                  show_repost_bubble={true}
                  post={post}
                  poster_uuid={post.poster.uuid}
                  public_profile={post.poster.public_profile}
                  style="margin-bottom: 0.5%;"
                />
              </div>
            </div>
            <br />
            <.live_component
              module={MkoussaelixirWeb.RootLive.PublicFeed.Post.Form}
              poster={@current_user}
              new_post_form={@new_post_form}
              id="public-post-form"
            />
          </section>
        <% else %>
          <h3>Check Your Email</h3>
          <p>A confirmation email was sent to <i><%= @current_user.email %></i>.</p>
          <p>
            To unlock full account features, you'll need to validate your account by clicking the link in the email that was sent to <%= @current_user.email %>.
          </p>
        <% end %>
      <% else %>
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
      <% end %>
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
