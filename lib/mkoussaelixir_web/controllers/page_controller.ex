defmodule MkoussaelixirWeb.PageController do
  use MkoussaelixirWeb, :controller

  alias Mkoussaelixir.Accounts.User
  def home(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    render(conn, :home, layout: false, user: conn.assigns.current_user)
  end
end
