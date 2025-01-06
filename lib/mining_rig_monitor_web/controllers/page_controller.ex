defmodule MiningRigMonitorWeb.PageController do
  use MiningRigMonitorWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
