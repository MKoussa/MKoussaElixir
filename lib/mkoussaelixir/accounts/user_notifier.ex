defmodule Mkoussaelixir.Accounts.UserNotifier do
  import Swoosh.Email

  alias Mkoussaelixir.Mailer

  # Delivers the email using the application mailer.
  defp deliver(
         recipient,
         subject,
         body,
         from_name \\ "MKoussa",
         from_email_name \\ System.get_env("MAILGUN_FROM", "noreply")
       ) do
    email =
      new()
      |> to(recipient)
      |> from(
        {from_name,
         "#{from_email_name}@#{System.get_env("MAILGUN_API_DOMAIN", "Missing email API domain")}"}
      )
      |> subject(subject)
      |> html_body(body)

    with {:ok, _metadata} <- Mailer.deliver(email) do
      {:ok, email}
    end
  end

  @doc """
  Deliver instructions to confirm account.
  """
  def deliver_confirmation_instructions(user, url) do
    deliver(
      user.email,
      "New Account Registration Confirmation Instructions",
      render_deliver_confirmation_instructions_html(user, url),
      "MKoussa Registration Confirmation",
      "regconf"
    )
  end

  defp render_deliver_confirmation_instructions_html(user, url) do
    {curYear, _} =
      DateTime.now!("Etc/UTC")
      |> Date.year_of_era()

    """
    <!DOCTYPE html>
    <html style="font-family: 'Helvetica Neue', Helvetica, Arial, sans-serif; box-sizing: border-box; font-size: 14px; margin: 0;">
    <head>
    <meta name="viewport" content="width=device-width" />
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <title>Actionable emails e.g. reset password</title>
    </head>
    <body>
    <header style="background-color: black; color: #C46DC4">
    <h3>Hello #{user.email},</h3>
    </header>
    <main>
    <p>Thank you for creating a new user account.</p>

    <p>Before you can fully utilize your new account, you need to confirm your account by visiting the link below:</p>
    <a href=#{url}>Confirm Account</a>
    <br />
    <p>Or copy the link into your browser:</p>
    <p>#{url}</p>

    <p>If you didn't create an account with us, please ignore this.</p>
    </main>
    <footer>
    <p>Please do not reply to this email as it is not monitored.</p>
    <p>Instead, email <email>support@mkoussa.com</email> for help</p>
    <br />
    <p>All Rights Reserved | <a href="https://www.mkoussa.com/">MKoussa.com</a> | #{curYear}</p>
    </footer>
    </body>
    </html>
    """
  end

  @doc """
  Deliver instructions to reset a user password.
  """
  def deliver_reset_password_instructions(user, url) do
    deliver(user.email, "Reset password instructions", """

    ==============================

    Hi #{user.email},

    You can reset your password by visiting the URL below:

    #{url}

    If you didn't request this change, please ignore this.

    ==============================
    """)
  end

  @doc """
  Deliver instructions to update a user email.
  """
  def deliver_update_email_instructions(user, url) do
    deliver(user.email, "Update email instructions", """

    ==============================

    Hi #{user.email},

    You can change your email by visiting the URL below:

    #{url}

    If you didn't request this change, please ignore this.

    ==============================
    """)
  end
end
