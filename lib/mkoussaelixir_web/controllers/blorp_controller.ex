defmodule MkoussaelixirWeb.BlorpController do
  use MkoussaelixirWeb, :controller

  def index(conn, _params) do
    render(conn, :index)
  end

  def original(conn, _params) do
    render(conn, :original)
  end
end
