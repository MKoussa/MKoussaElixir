defmodule MkoussaelixirWeb.UserLoginLive do
  use MkoussaelixirWeb, :live_view

  on_mount {MkoussaelixirWeb.UserAuth, :redirect_if_user_is_authenticated}

  def render(assigns) do
    ~H"""
    <div>
      <.header>
        Login
        <:subtitle>
          Don't have an account?
          <.link patch={~p"/users/register"}>
            Sign up
          </.link>
          for an account today! Did you
          <.link patch={~p"/users/reset_password"}>
            forget your password?
          </.link>
        </:subtitle>
      </.header>

      <.simple_form for={@form} id="login_form" action={~p"/users/log_in"} phx-update="ignore">
        <.error :if={[] != @form[:errors]}>
          Oops, something went wrong! Please check the errors below.
        </.error>

        <.input field={@form[:email]} type="email" label="Email" required />
        <.input field={@form[:password]} type="password" label="Password" required />

        <:actions>
          <.input field={@form[:remember_me]} type="checkbox" label="Keep me logged in" />
          <br />
        </:actions>
        <:actions>
          <.button phx-disable-with="Logging in...">
            Log in <span aria-hidden="true">→</span>
          </.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  def mount(_params, _session, socket) do
    email = Phoenix.Flash.get(socket.assigns.flash, :email)
    form = to_form(%{"email" => email}, as: "user")
    {:ok, assign(socket, form: form), temporary_assigns: [form: form]}
  end
end
