# defmodule MkoussaelixirWeb.RootLive.NewSessionLive do
#   use MkoussaelixirWeb, :live_view

#   def render(assigns) do
#     ~H"""
#     <div>
#       <.header>
#         Log in to account
#         <:subtitle>
#           Don't have an account?
#           <.link navigate={~p"/users/register"}>
#             Sign up
#           </.link>
#           for an account now.
#         </:subtitle>
#       </.header>

#       <.simple_form :let={f} for={@conn.params["current_user"]} as={:user} action={~p"/users/log_in"}>
#         <.error :if={@error_message}><%= @error_message %></.error>

#         <.input field={f[:email]} type="email" label="Email" required />
#         <.input field={f[:password]} type="password" label="Password" required />

#         <:actions :let={f}>
#           <.input field={f[:remember_me]} type="checkbox" label="Keep me logged in" />
#           <.link href={~p"/users/reset_password"}>
#             Forgot your password?
#           </.link>
#         </:actions>
#         <:actions>
#           <.button phx-disable-with="Logging in...">
#             Log in <span aria-hidden="true">→</span>
#           </.button>
#         </:actions>
#       </.simple_form>
#     </div>
#     """
#   end
# end
