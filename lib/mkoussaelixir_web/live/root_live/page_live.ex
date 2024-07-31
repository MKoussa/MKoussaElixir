defmodule MkoussaelixirWeb.PageLive do
  use MkoussaelixirWeb, :live_view

  on_mount {MkoussaelixirWeb.UserAuth, :mount_current_user}

  attr :user, :string, required: false, default: nil

  def render(assigns) do
    ~H"""
    <div class="root-transition">
      <%= if is_nil(@current_user) do %>
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
      <% else %>
        <%= if is_nil(@current_user.confirmed_at) do %>
          <h3>Check Your Email</h3>
          <p>A confirmation email was sent to <i><%= @current_user.email %></i>.</p>
          <p>
            color: black;
            font-family: 'Bebas Neue';
            To unlock full account features, you'll need to validate your account by clicking the link in the email that was sent to <%= @user.email %>.
          </p>
        <% else %>
          <h2>Hello Again!</h2>
          <p>It's <i>so</i> good to see you again!</p>
          <br />
          <p>Thank you for being a member and for being you!</p>
          <br />
          <h3 style="animation: rainbow-color 2.5s linear; animation-iteration-count: infinite;">
            _~♥- YOU ARE LOVED -♥~_
          </h3>
        <% end %>
      <% end %>
    </div>
    """
  end

  def mount(params, session, socket) do
    IO.inspect(params)
    IO.inspect(session)
    IO.inspect(socket)
    {:ok, assign(socket, :current_user, socket.assigns.current_user)}
  end
end
