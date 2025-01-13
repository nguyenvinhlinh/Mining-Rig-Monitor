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


  defp create_asic_miner_log(_) do
    asic_miner_log = asic_miner_log_fixture()
    %{asic_miner_log: asic_miner_log}
  end
end
