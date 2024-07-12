defmodule MiningRigMonitorWeb.MiningRigLiveTest do
  use MiningRigMonitorWeb.ConnCase

  import Phoenix.LiveViewTest
  import MiningRigMonitor.MiningRigsFixtures

  @create_attrs %{vga_1_pci_bus_id: "some vga_1_pci_bus_id", ram_1_manufacture: "some ram_1_manufacture", ram_4_size: "some ram_4_size", code: "some code", vga_1_name: "some vga_1_name", ram_3_part_number: "some ram_3_part_number", vga_1_vbios_version: "some vga_1_vbios_version", ram_4_part_number: "some ram_4_part_number", vga_2_pci_bus_id: "some vga_2_pci_bus_id", ram_3_type: "some ram_3_type", vga_4_name: "some vga_4_name", vga_1_driver_version: "some vga_1_driver_version", ram_1_type: "some ram_1_type", ram_2_part_number: "some ram_2_part_number", ram_3_manufacture: "some ram_3_manufacture", vga_2_vbios_version: "some vga_2_vbios_version", ram_2_type: "some ram_2_type", vga_3_vbios_version: "some vga_3_vbios_version", vga_3_name: "some vga_3_name", ram_3_size: "some ram_3_size", cpu_1_name: "some cpu_1_name", ram_1_size: "some ram_1_size", vga_3_driver_version: "some vga_3_driver_version", ram_2_size: "some ram_2_size", vga_4_pci_bus_id: "some vga_4_pci_bus_id", vga_1_total_memory: "some vga_1_total_memory", vga_3_total_memory: "some vga_3_total_memory", ram_1_part_number: "some ram_1_part_number", ram_2_manufacture: "some ram_2_manufacture", name: "some name", vga_2_total_memory: "some vga_2_total_memory", ram_4_manufacture: "some ram_4_manufacture", vga_4_vbios_version: "some vga_4_vbios_version", vga_3_pci_bus_id: "some vga_3_pci_bus_id", vga_4_driver_version: "some vga_4_driver_version", ram_4_type: "some ram_4_type", cpu_2_name: "some cpu_2_name", vga_2_name: "some vga_2_name", vga_2_driver_version: "some vga_2_driver_version", vga_4_total_memory: "some vga_4_total_memory"}
  @update_attrs %{vga_1_pci_bus_id: "some updated vga_1_pci_bus_id", ram_1_manufacture: "some updated ram_1_manufacture", ram_4_size: "some updated ram_4_size", code: "some updated code", vga_1_name: "some updated vga_1_name", ram_3_part_number: "some updated ram_3_part_number", vga_1_vbios_version: "some updated vga_1_vbios_version", ram_4_part_number: "some updated ram_4_part_number", vga_2_pci_bus_id: "some updated vga_2_pci_bus_id", ram_3_type: "some updated ram_3_type", vga_4_name: "some updated vga_4_name", vga_1_driver_version: "some updated vga_1_driver_version", ram_1_type: "some updated ram_1_type", ram_2_part_number: "some updated ram_2_part_number", ram_3_manufacture: "some updated ram_3_manufacture", vga_2_vbios_version: "some updated vga_2_vbios_version", ram_2_type: "some updated ram_2_type", vga_3_vbios_version: "some updated vga_3_vbios_version", vga_3_name: "some updated vga_3_name", ram_3_size: "some updated ram_3_size", cpu_1_name: "some updated cpu_1_name", ram_1_size: "some updated ram_1_size", vga_3_driver_version: "some updated vga_3_driver_version", ram_2_size: "some updated ram_2_size", vga_4_pci_bus_id: "some updated vga_4_pci_bus_id", vga_1_total_memory: "some updated vga_1_total_memory", vga_3_total_memory: "some updated vga_3_total_memory", ram_1_part_number: "some updated ram_1_part_number", ram_2_manufacture: "some updated ram_2_manufacture", name: "some updated name", vga_2_total_memory: "some updated vga_2_total_memory", ram_4_manufacture: "some updated ram_4_manufacture", vga_4_vbios_version: "some updated vga_4_vbios_version", vga_3_pci_bus_id: "some updated vga_3_pci_bus_id", vga_4_driver_version: "some updated vga_4_driver_version", ram_4_type: "some updated ram_4_type", cpu_2_name: "some updated cpu_2_name", vga_2_name: "some updated vga_2_name", vga_2_driver_version: "some updated vga_2_driver_version", vga_4_total_memory: "some updated vga_4_total_memory"}
  @invalid_attrs %{vga_1_pci_bus_id: nil, ram_1_manufacture: nil, ram_4_size: nil, code: nil, vga_1_name: nil, ram_3_part_number: nil, vga_1_vbios_version: nil, ram_4_part_number: nil, vga_2_pci_bus_id: nil, ram_3_type: nil, vga_4_name: nil, vga_1_driver_version: nil, ram_1_type: nil, ram_2_part_number: nil, ram_3_manufacture: nil, vga_2_vbios_version: nil, ram_2_type: nil, vga_3_vbios_version: nil, vga_3_name: nil, ram_3_size: nil, cpu_1_name: nil, ram_1_size: nil, vga_3_driver_version: nil, ram_2_size: nil, vga_4_pci_bus_id: nil, vga_1_total_memory: nil, vga_3_total_memory: nil, ram_1_part_number: nil, ram_2_manufacture: nil, name: nil, vga_2_total_memory: nil, ram_4_manufacture: nil, vga_4_vbios_version: nil, vga_3_pci_bus_id: nil, vga_4_driver_version: nil, ram_4_type: nil, cpu_2_name: nil, vga_2_name: nil, vga_2_driver_version: nil, vga_4_total_memory: nil}

  defp create_mining_rig(_) do
    mining_rig = mining_rig_fixture()
    %{mining_rig: mining_rig}
  end

  describe "Index" do
    setup [:create_mining_rig]

    test "lists all mining_rigs", %{conn: conn, mining_rig: mining_rig} do
      {:ok, _index_live, html} = live(conn, ~p"/mining_rigs")

      assert html =~ "Listing Mining rigs"
      assert html =~ mining_rig.vga_1_pci_bus_id
    end

    test "saves new mining_rig", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/mining_rigs")

      assert index_live |> element("a", "New Mining rig") |> render_click() =~
               "New Mining rig"

      assert_patch(index_live, ~p"/mining_rigs/new")

      assert index_live
             |> form("#mining_rig-form", mining_rig: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#mining_rig-form", mining_rig: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/mining_rigs")

      html = render(index_live)
      assert html =~ "Mining rig created successfully"
      assert html =~ "some vga_1_pci_bus_id"
    end

    test "updates mining_rig in listing", %{conn: conn, mining_rig: mining_rig} do
      {:ok, index_live, _html} = live(conn, ~p"/mining_rigs")

      assert index_live |> element("#mining_rigs-#{mining_rig.id} a", "Edit") |> render_click() =~
               "Edit Mining rig"

      assert_patch(index_live, ~p"/mining_rigs/#{mining_rig}/edit")

      assert index_live
             |> form("#mining_rig-form", mining_rig: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#mining_rig-form", mining_rig: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/mining_rigs")

      html = render(index_live)
      assert html =~ "Mining rig updated successfully"
      assert html =~ "some updated vga_1_pci_bus_id"
    end

    test "deletes mining_rig in listing", %{conn: conn, mining_rig: mining_rig} do
      {:ok, index_live, _html} = live(conn, ~p"/mining_rigs")

      assert index_live |> element("#mining_rigs-#{mining_rig.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#mining_rigs-#{mining_rig.id}")
    end
  end

  describe "Show" do
    setup [:create_mining_rig]

    test "displays mining_rig", %{conn: conn, mining_rig: mining_rig} do
      {:ok, _show_live, html} = live(conn, ~p"/mining_rigs/#{mining_rig}")

      assert html =~ "Show Mining rig"
      assert html =~ mining_rig.vga_1_pci_bus_id
    end

    test "updates mining_rig within modal", %{conn: conn, mining_rig: mining_rig} do
      {:ok, show_live, _html} = live(conn, ~p"/mining_rigs/#{mining_rig}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Mining rig"

      assert_patch(show_live, ~p"/mining_rigs/#{mining_rig}/show/edit")

      assert show_live
             |> form("#mining_rig-form", mining_rig: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#mining_rig-form", mining_rig: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/mining_rigs/#{mining_rig}")

      html = render(show_live)
      assert html =~ "Mining rig updated successfully"
      assert html =~ "some updated vga_1_pci_bus_id"
    end
  end
end
