defmodule MkoussaelixirWeb.LoguesdkController do
  use MkoussaelixirWeb, :controller

  def index(conn, _params) do
    render(conn, :index)
  end

  def stutter_mod_fx(conn, _params) do
    render(conn, :stutter_mod_fx)
  end

  def reverse_echo_delay_fx(conn, _params) do
    render(conn, :reverse_echo_delay_fx)
  end

  def fx(conn, _params) do
    render(conn, :fx)
  end

  def oscillators(conn, _params) do
    render(conn, :oscillators)
  end

  def resources(conn, _params) do
    render(conn, :resources)
  end
end
