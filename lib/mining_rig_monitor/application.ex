defmodule MiningRigMonitor.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      MiningRigMonitorWeb.Telemetry,
      MiningRigMonitor.Repo,
      {DNSCluster, query: Application.get_env(:mining_rig_monitor, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: MiningRigMonitor.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: MiningRigMonitor.Finch},
      # Start a worker by calling: MiningRigMonitor.Worker.start_link(arg)
      # {MiningRigMonitor.Worker, arg},
      # Start to serve requests, typically the last entry
      MiningRigMonitorWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: MiningRigMonitor.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    MiningRigMonitorWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
