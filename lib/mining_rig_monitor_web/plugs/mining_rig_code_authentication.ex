defmodule MiningRigMonitorWeb.Plugs.MiningRigCodeAuthentication do
  @behaviour Plug

  import Plug.Conn
  alias MiningRigMonitor.MiningRigs

  @header_name "mining_rig_code"

  def init(_opts), do: :nil

  def call(conn, _opts) do
    with {:ok, mining_rig_code} <- get_mining_rig_code(conn),
         {:ok, mining_rig} <- get_mining_rig(mining_rig_code)
      do
      conn
      |> assign(:mining_rig, mining_rig)
    else
      {:error, :mining_rig_code_not_exist} ->
        handle_mining_rig_code_not_exist(conn)
      {:error, :mining_rig_code_invalid} ->
        handle_mining_rig_code_invalid(conn)
    end
  end

  def get_mining_rig_code(conn) do
    mining_rig_code = conn
    |> Plug.Conn.get_req_header(@header_name)
    |> List.first

    if Kernel.is_nil(mining_rig_code) do
      {:error, :mining_rig_code_not_exist }
    else
      {:ok, mining_rig_code}
    end
  end

  def get_mining_rig(mining_rig_code) do
    case MiningRigs.get_mining_rig_by_code(mining_rig_code) do
      nil -> {:error, :mining_rig_code_invalid}
      mining_rig -> {:ok, mining_rig}
    end
  end

  def handle_mining_rig_code_not_exist(conn) do
    body = %{
      "message" => "MINING_RIG_CODE does not exist in request header."
    }
    conn
    |> put_status(401)
    |> Phoenix.Controller.json(body)
    |> halt()
  end

  def handle_mining_rig_code_invalid(conn) do
    body = %{
      "message" => "MINING_RIG_CODE invalid."
    }
    conn
    |> put_status(401)
    |> Phoenix.Controller.json(body)
    |> halt()
  end
end
