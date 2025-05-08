defmodule MiningRigMonitorWeb.AsicMinerControllerTest do
  use MiningRigMonitorWeb.ConnCase
  alias MiningRigMonitor.AsicMinersFixtures

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "get_expected_status_test_group" do
    setup [:create_asic_miner]

    test "get expected_status with valid API_CODE ",
      %{conn: conn, asic_miner: asic_miner}  do
      conn_mod = conn
      |> put_req_header("api_code", asic_miner.api_code)
      |> get(~p"/api/v1/asic_miners/expected_status")

      test_body = json_response(conn_mod, 200)
      expected_body = %{
        "asic_expected_status" =>  "on",
        "light_expected_status" => "off",
      }
      assert test_body == expected_body
    end

    test "get expected_status with invalid API_CODE", %{conn: conn} do
      conn_mod = conn
      |> put_req_header("api_code", "an invalid API_CODE")
      |> get(~p"/api/v1/asic_miners/expected_status")
      json_response(conn_mod, 401)
    end
  end

  describe "get_expected_status_many_test_group" do
    setup [:create_asic_miner_list]

    test "get_expected_status_many with valid API_CODE list",
      %{conn: conn, asic_miner_1: asic_miner_1, asic_miner_2: asic_miner_2} do
      api_code_list = [asic_miner_1.api_code, asic_miner_2.api_code]
      post_body = %{
        "api_code_list" => api_code_list
      }
      conn_mod = conn
      |> post(~p"/api/v1/asic_miners/expected_status_many", post_body)

      test_body = json_response(conn_mod, 200)
      expected_body = %{
        "#{asic_miner_1.api_code}" => %{
          "asic_expected_status" =>  "on",
          "light_expected_status" => "off",
        },
        "#{asic_miner_2.api_code}" => %{
          "asic_expected_status" =>  "on",
          "light_expected_status" => "off",
        }
      }
      assert test_body == expected_body
    end

    test "get_expected_status_many with invalid API_CODE list", %{conn: conn} do
      post_body = %{
        "api_code_list" => ["invalid api_code 1", "invalid_api_code_2"]
      }
      conn_mod = conn
      |> post(~p"/api/v1/asic_miners/expected_status_many", post_body)

      test_body = json_response(conn_mod, 200)
      expected_body = %{}
      assert test_body == expected_body
    end
  end

  defp create_asic_miner(_) do
    asic_miner = AsicMinersFixtures.asic_miner_fixture_by_commander()
    %{asic_miner: asic_miner}
  end

  defp create_asic_miner_list(_) do
    asic_miner_1 = AsicMinersFixtures.asic_miner_fixture_by_commander(%{"name" => "Thanh Long", "api_code" => "api_code_1"})
    asic_miner_2 = AsicMinersFixtures.asic_miner_fixture_by_commander(%{"name" => "Bach Ho", "api_code" => "api_code_2"})
    %{asic_miner_1: asic_miner_1, asic_miner_2: asic_miner_2}
  end
end
