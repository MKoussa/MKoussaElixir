defmodule MkoussaelixirWeb.PageLive do
  use MkoussaelixirWeb, :live_view

  alias Mkoussaelixir.Posts
  alias Mkoussaelixir.Posts.Post

  on_mount {MkoussaelixirWeb.UserAuth, :mount_current_user}

  attr :current_user, :string, required: false, default: nil

  def render(assigns) do
    ~H"""
    <div class="root-transition">
      <%= if @current_user do %>
        <%= if @current_user.confirmed_at do %>
          <h2>Hello Again!</h2>
          <p>It's <i>so</i> good to see you again!</p>
          <br />
          <p>Thank you for being a member and for being you!</p>
          <br />
          <h3 style="animation: rainbow-color 2.5s linear; animation-iteration-count: infinite;">
            _~♥- YOU ARE LOVED -♥~_
          </h3>
          <section class="chat-room">
            <h3>Public Feeeeeeed</h3>
            <p>this is the feed</p>
            <MkoussaelixirWeb.RootLive.PublicFeed.Posts.list_posts posts={@streams.posts} />
            <.live_component
              module={MkoussaelixirWeb.RootLive.PublicFeed.Post.Form}
              poster={@current_user}
              new_post_form={@new_post_form}
              id="public-post-feed"
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
      new_post_form = Posts.change_post(%Post{})

      {:ok,
       socket
       |> assign_posts()
       |> assign(:new_post_form, to_form(new_post_form))}
    else
      {:ok, socket}
    end
  end

  def assign_posts(socket) do
    posts = Mkoussaelixir.Posts.last_ten_public_posts()

    socket
    |> stream(:posts, posts)
  end
end
