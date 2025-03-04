defmodule MiningRigMonitorWeb.CpuGpuMinerLiveTest do
  use MiningRigMonitorWeb.ConnCase

  import Phoenix.LiveViewTest
  import MiningRigMonitor.CpuGpuMinersFixtures

  @create_attrs %{name: "some name", api_code: "some api_code", cpu_1_name: "some cpu_1_name", cpu_2_name: "some cpu_2_name", ram_size: "some ram_size", gpu_1_name: "some gpu_1_name", gpu_2_name: "some gpu_2_name", gpu_3_name: "some gpu_3_name", gpu_4_name: "some gpu_4_name", gpu_5_name: "some gpu_5_name", gpu_6_name: "some gpu_6_name", gpu_7_name: "some gpu_7_name", gpu_8_name: "some gpu_8_name"}
  @update_attrs %{name: "some updated name", api_code: "some updated api_code", cpu_1_name: "some updated cpu_1_name", cpu_2_name: "some updated cpu_2_name", ram_size: "some updated ram_size", gpu_1_name: "some updated gpu_1_name", gpu_2_name: "some updated gpu_2_name", gpu_3_name: "some updated gpu_3_name", gpu_4_name: "some updated gpu_4_name", gpu_5_name: "some updated gpu_5_name", gpu_6_name: "some updated gpu_6_name", gpu_7_name: "some updated gpu_7_name", gpu_8_name: "some updated gpu_8_name"}
  @invalid_attrs %{name: nil, api_code: nil, cpu_1_name: nil, cpu_2_name: nil, ram_size: nil, gpu_1_name: nil, gpu_2_name: nil, gpu_3_name: nil, gpu_4_name: nil, gpu_5_name: nil, gpu_6_name: nil, gpu_7_name: nil, gpu_8_name: nil}

  defp create_cpu_gpu_miner(_) do
    cpu_gpu_miner = cpu_gpu_miner_fixture()
    %{cpu_gpu_miner: cpu_gpu_miner}
  end

  describe "Index" do
    setup [:create_cpu_gpu_miner]

    test "lists all cpu_gpu_miners", %{conn: conn, cpu_gpu_miner: cpu_gpu_miner} do
      {:ok, _index_live, html} = live(conn, ~p"/cpu_gpu_miners")

      assert html =~ "Listing Cpu gpu miners"
      assert html =~ cpu_gpu_miner.name
    end

    test "saves new cpu_gpu_miner", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/cpu_gpu_miners")

      assert index_live |> element("a", "New Cpu gpu miner") |> render_click() =~
               "New Cpu gpu miner"

      assert_patch(index_live, ~p"/cpu_gpu_miners/new")

      assert index_live
             |> form("#cpu_gpu_miner-form", cpu_gpu_miner: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#cpu_gpu_miner-form", cpu_gpu_miner: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/cpu_gpu_miners")

      html = render(index_live)
      assert html =~ "Cpu gpu miner created successfully"
      assert html =~ "some name"
    end

    test "updates cpu_gpu_miner in listing", %{conn: conn, cpu_gpu_miner: cpu_gpu_miner} do
      {:ok, index_live, _html} = live(conn, ~p"/cpu_gpu_miners")

      assert index_live |> element("#cpu_gpu_miners-#{cpu_gpu_miner.id} a", "Edit") |> render_click() =~
               "Edit Cpu gpu miner"

      assert_patch(index_live, ~p"/cpu_gpu_miners/#{cpu_gpu_miner}/edit")

      assert index_live
             |> form("#cpu_gpu_miner-form", cpu_gpu_miner: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#cpu_gpu_miner-form", cpu_gpu_miner: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/cpu_gpu_miners")

      html = render(index_live)
      assert html =~ "Cpu gpu miner updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes cpu_gpu_miner in listing", %{conn: conn, cpu_gpu_miner: cpu_gpu_miner} do
      {:ok, index_live, _html} = live(conn, ~p"/cpu_gpu_miners")

      assert index_live |> element("#cpu_gpu_miners-#{cpu_gpu_miner.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#cpu_gpu_miners-#{cpu_gpu_miner.id}")
    end
  end

  describe "Show" do
    setup [:create_cpu_gpu_miner]

    test "displays cpu_gpu_miner", %{conn: conn, cpu_gpu_miner: cpu_gpu_miner} do
      {:ok, _show_live, html} = live(conn, ~p"/cpu_gpu_miners/#{cpu_gpu_miner}")

      assert html =~ "Show Cpu gpu miner"
      assert html =~ cpu_gpu_miner.name
    end

    test "updates cpu_gpu_miner within modal", %{conn: conn, cpu_gpu_miner: cpu_gpu_miner} do
      {:ok, show_live, _html} = live(conn, ~p"/cpu_gpu_miners/#{cpu_gpu_miner}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Cpu gpu miner"

      assert_patch(show_live, ~p"/cpu_gpu_miners/#{cpu_gpu_miner}/show/edit")

      assert show_live
             |> form("#cpu_gpu_miner-form", cpu_gpu_miner: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#cpu_gpu_miner-form", cpu_gpu_miner: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/cpu_gpu_miners/#{cpu_gpu_miner}")

      html = render(show_live)
      assert html =~ "Cpu gpu miner updated successfully"
      assert html =~ "some updated name"
    end
  end
end
