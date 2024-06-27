defmodule MiningRigMonitor.Repo do
  use Ecto.Repo,
    otp_app: :mining_rig_monitor,
    adapter: Ecto.Adapters.Postgres
end
