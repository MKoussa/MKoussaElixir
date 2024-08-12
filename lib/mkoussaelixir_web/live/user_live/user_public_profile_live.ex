defmodule MkoussaelixirWeb.UserPublicProfileLive do
  use MkoussaelixirWeb, :live_view

  alias Mkoussaelixir.Accounts

  def render(assigns) do
    ~H"""
    <section style={"background-color: #{@public_profile.public_post_background_color}; color: #{@public_profile.public_post_foreground_color};"}>
      <h3><%= @public_profile.username %></h3>
      <p><%= @public_profile.bio %></p>
    </section>
    """
  end

  def mount(%{"uuid" => uuid}, _, socket) do
    public_profile = Accounts.get_public_profile_by_user_uuid(uuid)

    {:ok,
     socket
     |> assign(:public_profile, public_profile)}
  end
end
