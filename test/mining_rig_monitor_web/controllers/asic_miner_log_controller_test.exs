defmodule MiningRigMonitorWeb.AsicMinerLogControllerTest do
  use MiningRigMonitorWeb.ConnCase

  import MiningRigMonitor.AsicMinerLogsFixtures

  alias MiningRigMonitor.AsicMinerLogs.AsicMinerLog

  @create_attrs %{

  }
  @update_attrs %{

  }
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all asic_miner_logs", %{conn: conn} do
      conn = get(conn, ~p"/api/asic_miner_logs")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create asic_miner_log" do
    test "renders asic_miner_log when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/asic_miner_logs", asic_miner_log: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/asic_miner_logs/#{id}")

      assert %{
               "id" => ^id
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/asic_miner_logs", asic_miner_log: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update asic_miner_log" do
    setup [:create_asic_miner_log]

    test "renders asic_miner_log when data is valid", %{conn: conn, asic_miner_log: %AsicMinerLog{id: id} = asic_miner_log} do
      conn = put(conn, ~p"/api/asic_miner_logs/#{asic_miner_log}", asic_miner_log: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/asic_miner_logs/#{id}")

      assert %{
               "id" => ^id
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, asic_miner_log: asic_miner_log} do
      conn = put(conn, ~p"/api/asic_miner_logs/#{asic_miner_log}", asic_miner_log: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete asic_miner_log" do
    setup [:create_asic_miner_log]

    test "deletes chosen asic_miner_log", %{conn: conn, asic_miner_log: asic_miner_log} do
      conn = delete(conn, ~p"/api/asic_miner_logs/#{asic_miner_log}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/asic_miner_logs/#{asic_miner_log}")
      end
    end
  end

  defp create_asic_miner_log(_) do
    asic_miner_log = asic_miner_log_fixture()
    %{asic_miner_log: asic_miner_log}
  end
end
