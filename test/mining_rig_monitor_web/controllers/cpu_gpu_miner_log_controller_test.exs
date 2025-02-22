defmodule MiningRigMonitorWeb.CpuGpuMinerLogControllerTest do
  use MiningRigMonitorWeb.ConnCase

  import MiningRigMonitor.CpuGpuMinerLogsFixtures

  alias MiningRigMonitor.CpuGpuMinerLogs.CpuGpuMinerLog

  @create_attrs %{

  }
  @update_attrs %{

  }
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all cpu_gpu_miner_logs", %{conn: conn} do
      conn = get(conn, ~p"/api/cpu_gpu_miner_logs")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create cpu_gpu_miner_log" do
    test "renders cpu_gpu_miner_log when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/cpu_gpu_miner_logs", cpu_gpu_miner_log: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/cpu_gpu_miner_logs/#{id}")

      assert %{
               "id" => ^id
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/cpu_gpu_miner_logs", cpu_gpu_miner_log: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update cpu_gpu_miner_log" do
    setup [:create_cpu_gpu_miner_log]

    test "renders cpu_gpu_miner_log when data is valid", %{conn: conn, cpu_gpu_miner_log: %CpuGpuMinerLog{id: id} = cpu_gpu_miner_log} do
      conn = put(conn, ~p"/api/cpu_gpu_miner_logs/#{cpu_gpu_miner_log}", cpu_gpu_miner_log: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/cpu_gpu_miner_logs/#{id}")

      assert %{
               "id" => ^id
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, cpu_gpu_miner_log: cpu_gpu_miner_log} do
      conn = put(conn, ~p"/api/cpu_gpu_miner_logs/#{cpu_gpu_miner_log}", cpu_gpu_miner_log: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete cpu_gpu_miner_log" do
    setup [:create_cpu_gpu_miner_log]

    test "deletes chosen cpu_gpu_miner_log", %{conn: conn, cpu_gpu_miner_log: cpu_gpu_miner_log} do
      conn = delete(conn, ~p"/api/cpu_gpu_miner_logs/#{cpu_gpu_miner_log}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/cpu_gpu_miner_logs/#{cpu_gpu_miner_log}")
      end
    end
  end

  defp create_cpu_gpu_miner_log(_) do
    cpu_gpu_miner_log = cpu_gpu_miner_log_fixture()
    %{cpu_gpu_miner_log: cpu_gpu_miner_log}
  end
end
