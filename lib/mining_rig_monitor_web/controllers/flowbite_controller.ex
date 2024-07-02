defmodule MiningRigMonitorWeb.FlowbiteController do
  use MiningRigMonitorWeb, :controller

  def flowbite(conn, _params) do
    render(conn, :flowbite)
  end
end
