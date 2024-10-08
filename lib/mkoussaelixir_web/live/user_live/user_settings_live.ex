defmodule MkoussaelixirWeb.UserSettingsLive do
  alias Mkoussaelixir.Accounts.PublicProfile
  use MkoussaelixirWeb, :live_view

  on_mount {MkoussaelixirWeb.UserAuth, :ensure_authenticated}

  alias Mkoussaelixir.Accounts

  def mount(%{"token" => token}, _session, socket) do
    socket =
      case Accounts.update_user_email(socket.assigns.current_user, token) do
        :ok ->
          put_flash(socket, :info, "Email changed successfully.")

        :error ->
          put_flash(socket, :error, "Email change link is invalid or it has expired.")
      end

    {:ok, push_navigate(socket, to: ~p"/users/settings")}
  end

  def mount(_params, _session, socket) do
    if socket.assigns.current_user do
      user = socket.assigns.current_user
      email_changeset = Accounts.change_user_email(user)
      password_changeset = Accounts.change_user_password(user)
      public_profile_changeset = PublicProfile.changeset(user.public_profile)

      socket =
        socket
        |> assign(:current_user, user)
        |> assign(:current_password, nil)
        |> assign(:email_form_current_password, nil)
        |> assign(:current_email, user.email)
        |> assign(:email_form, to_form(email_changeset))
        |> assign(:password_form, to_form(password_changeset))
        |> assign(:public_profile_form, to_form(public_profile_changeset))
        |> assign(:trigger_submit, false)

      {:ok, socket}
    else
      {:ok,
       socket
       |> redirect(~p"/users/log_in")}
    end
  end

  def handle_event("validate_email", params, socket) do
    %{"current_password" => password, "user" => user_params} = params

    email_form =
      socket.assigns.current_user
      |> Accounts.change_user_email(user_params)
      |> Map.put(:action, :validate)
      |> to_form()

    {:noreply, assign(socket, email_form: email_form, email_form_current_password: password)}
  end

  def handle_event("update_email", params, socket) do
    %{"current_password" => password, "user" => user_params} = params
    user = socket.assigns.current_user

    case Accounts.apply_user_email(user, password, user_params) do
      {:ok, applied_user} ->
        Accounts.deliver_user_update_email_instructions(
          applied_user,
          user.email,
          &url(~p"/users/settings/confirm_email/#{&1}")
        )

        info = "A link to confirm your email change has been sent to the new address."
        {:noreply, socket |> put_flash(:info, info) |> assign(email_form_current_password: nil)}

      {:error, changeset} ->
        {:noreply, assign(socket, :email_form, to_form(Map.put(changeset, :action, :insert)))}
    end
  end

  def handle_event(
        "update_public_profile",
        %{
          "username" => username,
          "bio" => bio,
          "public_post_background_color" => public_post_background_color,
          "public_post_foreground_color" => public_post_foreground_color,
          "public_post_border_size" => public_post_border_size,
          "public_post_border_type" => public_post_border_type,
          "public_post_border_color" => public_post_border_color,
          "chat_background_color_me" => chat_background_color_me,
          "chat_foreground_color_me" => chat_foreground_color_me,
          "chat_background_color_them" => chat_background_color_them,
          "chat_foreground_color_them" => chat_foreground_color_them
        },
        socket
      ) do
    user = socket.assigns.current_user

    case Accounts.update_user_public_profile(user, %{
           username: username,
           bio: bio,
           public_post_background_color: public_post_background_color,
           public_post_foreground_color: public_post_foreground_color,
           public_post_border_size: public_post_border_size,
           public_post_border_type: public_post_border_type,
           public_post_border_color: public_post_border_color,
           chat_background_color_me: chat_background_color_me,
           chat_foreground_color_me: chat_foreground_color_me,
           chat_background_color_them: chat_background_color_them,
           chat_foreground_color_them: chat_foreground_color_them
         }) do
      {:ok, _profile} ->
        {:noreply,
         socket
         |> put_flash(:info, "Your profile was successfully updated!")
         |> redirect(to: ~p"/users/public_profile/#{user.uuid}")}

      {:error, _changeset} ->
        {:noreply,
         socket
         |> put_flash(:error, "Error Updating Profile.")
         |> push_navigate(to: ~p"/users/settings")}
    end
  end

  def handle_event("validate_password", params, socket) do
    %{"current_password" => password, "user" => user_params} = params

    password_form =
      socket.assigns.current_user
      |> Accounts.change_user_password(user_params)
      |> Map.put(:action, :validate)
      |> to_form()

    {:noreply, assign(socket, password_form: password_form, current_password: password)}
  end

  def handle_event("update_password", params, socket) do
    %{"current_password" => password, "user" => user_params} = params
    user = socket.assigns.current_user

    case Accounts.update_user_password(user, password, user_params) do
      {:ok, user} ->
        password_form =
          user
          |> Accounts.change_user_password(user_params)
          |> to_form()

        {:noreply, assign(socket, trigger_submit: true, password_form: password_form)}

      {:error, changeset} ->
        {:noreply, assign(socket, password_form: to_form(changeset))}
    end
  end
end
