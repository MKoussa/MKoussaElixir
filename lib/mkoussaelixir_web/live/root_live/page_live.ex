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
          <h3>Public <i>Feeeeeeed</i></h3>
          <section class="chat-room">
            <div
              id="posts"
              style="height: calc(70vh - 10rem);
                     overflow: scroll;
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
        <br />
        <p>
          Build community with <%= @user_count %>+ unique and compelling users.
        </p>
        <p>Read, repost and boop over <%= @post_count %> posts.</p>
        <p>Live chat in one of 10 public rooms.</p>
        <p>Customizable posts and bio.</p>
        <p><i>This</i> is Web 3.0</p>
        <p><i>You</i> create your own experience.</p>
        <p><i>This is You.</i></p>

        <.link patch={~p"/users/register"}>
          <.button>Join Us Today</.button>
        </.link>
      <% end %>
    </div>
    """
  end

  def mount(_, _, socket) do
    if socket.assigns.current_user do
      if connected?(socket), do: Endpoint.subscribe("public_post_feed")

      new_post_form = Posts.change_post(%Post{})

      {:ok,
       socket
       |> assign_posts()
       |> assign(:new_post_form, to_form(new_post_form))}
    else
      {:ok,
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
      {:ok, post} ->
        {:noreply,
         socket
         |> insert_new_post(post)}

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
