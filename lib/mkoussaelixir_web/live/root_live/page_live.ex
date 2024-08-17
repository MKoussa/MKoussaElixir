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
          <%!-- <h2>Hello Again!</h2>
          <p>It's <i>so</i> good to see you again! Thank you for being a member and for being you!</p>
          <h3 style="animation: rainbow-color 2.5s linear; animation-iteration-count: infinite;">
            ~♥ YOU ARE LOVED ♥~
          </h3> --%>
          <h3>Public <i>Feeeeeeed</i></h3>
          <section class="chat-room">
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
        <.link patch={~p"/users/log_in"}>
          <.button>Log In</.button>
        </.link>
        <br />
        <br />
        <br />
        <.link patch={~p"/users/register"}>
          <.button>Create an Account</.button>
        </.link>
        <br />
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
      {:ok, socket}
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
