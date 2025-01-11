defmodule MiningRigMonitorWeb.Plugs.ApiCodeAuthentication do
  @behaviour Plug

  import Plug.Conn

  alias MiningRigMonitor.AsicMiners
  @header_name "api_code"


  def init(:asic_miner), do: :asic_miner
  def init(:cpu_gpu_miner), do: :cpu_gpu_miner


  def call(conn, :asic_miner) do
    with {:ok, api_code} <- get_api_code(conn),
         {:ok, asic_miner} <- get_asic_miner(api_code)
      do
      conn
      |> assign(:asic_miner, asic_miner)
    else
      {:error, :api_code_not_exist} ->
        handle_api_code_not_exist(conn)
      {:error, :mining_rig_code_invalid} ->
        handle_api_code_invalid(conn)
    end
  end



  def get_api_code(conn) do
    mining_rig_code = conn
    |> Plug.Conn.get_req_header(@header_name)
    |> List.first

    if Kernel.is_nil(mining_rig_code) do
      {:error, :api_code_not_exist }
    else
      {:ok, mining_rig_code}
    end
  end

  def get_asic_miner(api_code) do
    case AsicMiners.get_asic_miner_by_api_code(api_code) do
      nil -> {:error, :api_code_invalid}
      asic_miner -> {:ok, asic_miner}
    end
  end

  def handle_api_code_not_exist(conn) do
    body = %{
      "message" => "API_CODE does not exist in request header."
    }
    conn
    |> put_status(401)
    |> Phoenix.Controller.json(body)
    |> halt()
  end

  def handle_api_code_invalid(conn) do
    body = %{
      "message" => "API_CODE invalid."
    }
    conn
    |> put_status(401)
    |> Phoenix.Controller.json(body)
    |> halt()
  end
end
