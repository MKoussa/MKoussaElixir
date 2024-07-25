defmodule MkoussaelixirWeb.PageLive do
  use MkoussaelixirWeb, :live_view

  on_mount {MkoussaelixirWeb.UserAuth, :mount_current_user}

  attr :user, :string, required: false, default: nil

  def render(assigns) do
    IO.inspect(assigns)
    IO.puts("--------------ENDNEDNENDNEDNED-------------")

    ~H"""
    <section style="align-items: center; animation-name: backColor; animation-duration: 2s;">
      <%= if is_nil(assigns.user) do %>
        <h2>Welcome, <i>Friend</i></h2>
        <br />
        <.link href={~p"/users/log_in"}>
          <.button>Log In</.button>
        </.link>
        <br />
        <br />
        <br />
        <.link href={~p"/users/register"}>
          <.button>Create an Account</.button>
        </.link>
        <br />
      <% else %>
        <%= if is_nil(@user.confirmed_at) do %>
          <p>Please confirm your account.</p>
        <% else %>
          <h2>Hello Again, <%= @user.email %></h2>
          <p>It's <i>so</i> good to see you again!</p>
          <br />
          <p>Thank you for being a member and for being you!</p>
          <br />
          <h3 style="animation: rainbow-color 2.5s linear; animation-iteration-count: infinite;">
            _~♥- YOU ARE LOVED -♥~_
          </h3>
        <% end %>
      <% end %>
    </section>
    """
  end

  def mount(params, session, socket) do
    IO.inspect(params)
    IO.inspect(session)
    IO.inspect(socket)
    {:ok, assign(socket, :user, socket.assigns.current_user)}
  end
end
