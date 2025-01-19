defmodule MiningRigMonitorWeb.PingPongController do
  use MiningRigMonitorWeb, :controller

  def ping(conn, _params) do
    data = %{
      "message" => "pong"
    }
    conn
    |> json(data)
  end
end
