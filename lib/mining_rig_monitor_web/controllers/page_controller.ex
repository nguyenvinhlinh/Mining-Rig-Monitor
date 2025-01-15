defmodule MiningRigMonitorWeb.PageController do
  use MiningRigMonitorWeb, :controller

  def home(conn, _params) do
    redirect(conn, to: "/asic_miners")
  end
end
