defmodule MiningRigMonitorWeb.CpuGpuMinerLogControllerTest do
  use MiningRigMonitorWeb.ConnCase

  alias MiningRigMonitor.CpuGpuMinerLogs.CpuGpuMinerLog

  @create_attrs %{
    cpu_coin_name: "Monero",
    cpu_algorithm: "RandomX",
    cpu_hashrate: 1,
    cpu_hashrate_uom: "H/s"
  }

  @invalid_attrs %{
    cpu_coin_name: "Monero",
    cpu_algorithm: "RandomX", # missing cpu_hashrate
    cpu_hashrate_uom: "h/s"   # invalid cpu_hashrate_uom, should be `H/s` not `h/s`
  }

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end


  describe "create cpu_gpu_miner_log" do
    setup [:create_cpu_gpu_miner]

    test "renders cpu_gpu_miner_log when data is valid", %{conn: conn, cpu_gpu_miner: cpu_gpu_miner} do
      conn_mod = conn
      |> put_req_header("api_code", "some api_code")
      |> post(~p"/api/v1/cpu_gpu_miners/logs", @create_attrs)

      json_response(conn_mod, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, cpu_gpu_miner: cpu_gpu_miner} do
      conn_mod = conn
      |> put_req_header("api_code", "some api_code")
      |> post(~p"/api/v1/cpu_gpu_miners/logs", @invalid_attrs)

      body = json_response(conn_mod, 422)
      error_map = Map.get(body, "errors")
      assert error_map != %{}
      assert Map.keys(error_map) == ["cpu_coin_name", "cpu_hashrate_uom"]
    end
  end


  defp create_cpu_gpu_miner(_) do
    cpu_gpu_miner = MiningRigMonitor.CpuGpuMinersFixtures.cpu_gpu_miner_fixture()
    %{cpu_gpu_miner: cpu_gpu_miner}
  end
end
