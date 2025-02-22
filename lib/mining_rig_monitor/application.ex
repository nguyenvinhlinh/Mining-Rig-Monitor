defmodule MiningRigMonitor.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false
  use Application
  alias MiningRigMonitor.GenServer.AsicMinerOperationalIndex

  @impl true
  def start(_type, _args) do
    children = [
      MiningRigMonitorWeb.Telemetry,
      MiningRigMonitor.Repo,
      {DNSCluster, query: Application.get_env(:mining_rig_monitor, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: MiningRigMonitor.PubSub},
      {AsicMinerOperationalIndex, nil},
#      Uncomment it for dev env.
#      {MiningRigMonitor.Simulation.CpuGpuMinerLogGenerator, nil},
#      {MiningRigMonitor.Simulation.AsicMinerLogGenerator, nil},
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
