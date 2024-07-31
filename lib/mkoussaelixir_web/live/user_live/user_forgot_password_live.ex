defmodule MkoussaelixirWeb.UserForgotPasswordLive do
  use MkoussaelixirWeb, :live_view

  alias Mkoussaelixir.Accounts

  def render(assigns) do
    ~H"""
    <div class="root-transition">
      <.header>
        Forgot your password?
        <:subtitle>We'll send a password reset link to your inbox</:subtitle>
      </.header>

      <.simple_form for={@form} id="reset_password_form" phx-submit="send_email">
        <.input
          field={@form[:email]}
          label="Email"
          type="email"
          placeholder="Enter Your Email Address Here"
          required
        />
        <:actions>
          <.button phx-disable-with="Sending...">
            Send password reset instructions
          </.button>
        </:actions>
      </.simple_form>
      <p>
        <.link patch={~p"/users/register"}>Register</.link>
        | <.link patch={~p"/users/log_in"}>Log in</.link>
      </p>
    </div>
    """
  end

  def mount(_params, _session, socket) do
    {:ok, assign(socket, form: to_form(%{}, as: "user"))}
  end

  def handle_event("send_email", %{"user" => %{"email" => email}}, socket) do
    if user = Accounts.get_user_by_email(email) do
      Accounts.deliver_user_reset_password_instructions(
        user,
        &url(~p"/users/reset_password/#{&1}")
      )
    end

    info =
      "If your email is in our system, you will receive instructions to reset your password shortly."

    {:noreply,
     socket
     |> put_flash(:info, info)
     |> redirect(to: ~p"/")}
  end
end
