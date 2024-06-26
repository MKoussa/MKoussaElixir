defmodule MkoussaelixirWeb.ResourcesController do
  use MkoussaelixirWeb, :controller

  def index(conn, _params) do
    render(conn, :index)
  end
end
