defmodule MiningRigMonitorWeb.AsicRigMonitorRecordController do
  use MiningRigMonitorWeb, :controller

  def save(conn, params) do
    IO.inspect "DEBUG #{__ENV__.file} @#{__ENV__.line}"
    IO.inspect conn
    IO.inspect "END"
    json(conn, :ok)
  end
end
