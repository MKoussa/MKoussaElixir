defmodule Mkoussaelixir.Accounts.UserNotifier do
  import Swoosh.Email

  alias Mkoussaelixir.Mailer

  @doc """
  Deliver instructions to confirm account.
  """
  def deliver_confirmation_instructions(user, url) do
    deliver(
      user.email,
      "New Account Registration Confirmation Instructions",
      email_html_template(
        "MKoussa Confirm Account",
        """
        <h3>Hello #{user.email},</h3>
        <p>Thank you for creating a new user account.</p>

        <p>Before you can fully utilize your new account, you need to confirm your account by visiting the link below:</p>
        <a href=#{url}>Confirm Account</a>
        <br />
        <p>Or copy the link into your browser:</p>
        <p>#{url}</p>

        <p>If you didn't create an account with us, please ignore this.</p>
        """
      ),
      "MKoussa Registration Confirmation",
      "regconf"
    )
  end

  @doc """
  Deliver instructions to reset a user password.
  """
  def deliver_reset_password_instructions(user, url) do
    deliver(
      user.email,
      "MKoussa Reset Password Instructions",
      email_html_template(
        "MKoussa Reset Password",
        """
        <h3>Hello #{user.email},</h3>

        <p>To reset your password, visit the link below:</p>
        <a href=#{url}>Reset Password</a>
        <br />
        <p>Or copy the link into your browser:</p>
        <p>#{url}</p>

        <p>If you didn't request this, you can ignore it. </p>
        <br />
        """
      )
    )
  end

  @doc """
  Deliver instructions to update a user email.
  """
  def deliver_update_email_instructions(user, url) do
    deliver(
      user.email,
      "Update email instructions",
      email_html_template(
        "MKoussa Update Email",
        """
        <h3>Hello #{user.email},</h3>

        <p>To change your email, visit the link below:</p>
        <a href=#{url}>Change Email</a>
        <br />
        <p>Or copy the link into your browser:</p>
        <p>#{url}</p>

        <p>If you didn't request this, you can ignore it. </p>
        <br />
        """
      )
    )
  end

  defp email_html_template(title, inner_html) do
    {curYear, _} =
      DateTime.now!("Etc/UTC")
      |> Date.year_of_era()

    """
    <!DOCTYPE html>
    <html style="font-family: 'Helvetica Neue', Helvetica, Arial, sans-serif; box-sizing: border-box; font-size: 14px; margin: 30px;">
      <head>
        <meta name="viewport" content="width=device-width" />
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <title>#{title}</title>
      </head>
      <body>
        <header style="background-color: #080408; color: #C46DC4;">
          <h1>
            <span>&nbsp;MKoussa</span><br />
          </h1>
        </header>
        <main style="color: #0f090f;">
    """ <>
      inner_html <>
      """
          </main>
            <footer style="background-color: #0f090f; color: #C46DC4;">
              <br />
              <small>
                <i>
                  <p>&nbsp;&nbsp;Please do not reply to this email as it is not monitored.</p>
                  <p>&nbsp;&nbsp;Instead, email <email>support@mkoussa.com</email> for help.</p>
                </i>
              </small>
              <p>&nbsp;All Rights Reserved | <a href="https://www.mkoussa.com/">MKoussa.com</a> | #{curYear}</p>
              <br />
            </footer>
          </body>
        </html>
      """
  end

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
end
