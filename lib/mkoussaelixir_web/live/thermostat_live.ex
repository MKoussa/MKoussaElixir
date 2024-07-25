defmodule MkoussaelixirWeb.ThermostatLive do
  use MkoussaelixirWeb, :live_view

  def render(assigns) do
    ~H"""
    Curr Temp:<%= @temperature %>
    <.button phx-click="inc_temperature">+</.button>
    <.button phx-click="dec_temperature">-</.button>
    <.link patch={~p"/mkoussa"}>
      <.button>About</.button>
    </.link>
    <br /><br />
    """
  end

  def mount(_params, session, socket) do
    IO.puts("---- HERE ----")
    IO.inspect(session)
    IO.puts("---- END ----")

    temperature = 70
    {:ok, assign(socket, :temperature, temperature)}
  end

  def handle_event("inc_temperature", _params, socket) do
    {:noreply, update(socket, :temperature, &(&1 + 1))}
  end

  def handle_event("dec_temperature", _params, socket) do
    {:noreply, update(socket, :temperature, &(&1 - 1))}
  end
end
