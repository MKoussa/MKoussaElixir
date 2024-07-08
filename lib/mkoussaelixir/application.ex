defmodule Mkoussaelixir.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      Mkoussaelixir.Repo,
      MkoussaelixirWeb.Telemetry,
      {DNSCluster, query: Application.get_env(:mkoussaelixir, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Mkoussaelixir.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Mkoussaelixir.Finch},
      # Start a worker by calling: Mkoussaelixir.Worker.start_link(arg)
      # {Mkoussaelixir.Worker, arg},
      # Start to serve requests, typically the last entry
      MkoussaelixirWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Mkoussaelixir.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    MkoussaelixirWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
