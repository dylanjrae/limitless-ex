defmodule Limitless.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      LimitlessWeb.Telemetry,
      {DNSCluster, query: Application.get_env(:limitless, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Limitless.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Limitless.Finch},
      # Start a worker by calling: Limitless.Worker.start_link(arg)
      # {Limitless.Worker, arg},
      # Start to serve requests, typically the last entry
      LimitlessWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Limitless.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    LimitlessWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
