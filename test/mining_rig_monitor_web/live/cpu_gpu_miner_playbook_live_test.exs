defmodule MiningRigMonitorWeb.CpuGpuMinerPlaybookLiveTest do
  use MiningRigMonitorWeb.ConnCase

  import Phoenix.LiveViewTest
  import MiningRigMonitor.CpuGpuMinerPlaybooksFixtures

  @create_attrs %{cpu_gpu_miner_id: 42, software_name: "some software_name", software_version: "some software_version", command_argument: "some command_argument"}
  @update_attrs %{cpu_gpu_miner_id: 43, software_name: "some updated software_name", software_version: "some updated software_version", command_argument: "some updated command_argument"}
  @invalid_attrs %{cpu_gpu_miner_id: nil, software_name: nil, software_version: nil, command_argument: nil}

  defp create_cpu_gpu_miner_playbook(_) do
    cpu_gpu_miner_playbook = cpu_gpu_miner_playbook_fixture()
    %{cpu_gpu_miner_playbook: cpu_gpu_miner_playbook}
  end

  describe "Index" do
    setup [:create_cpu_gpu_miner_playbook]

    test "lists all cpu_gpu_miner_playbooks", %{conn: conn, cpu_gpu_miner_playbook: cpu_gpu_miner_playbook} do
      {:ok, _index_live, html} = live(conn, ~p"/cpu_gpu_miner_playbooks")

      assert html =~ "Listing Cpu gpu miner playbooks"
      assert html =~ cpu_gpu_miner_playbook.software_name
    end

    test "saves new cpu_gpu_miner_playbook", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/cpu_gpu_miner_playbooks")

      assert index_live |> element("a", "New Cpu gpu miner playbook") |> render_click() =~
               "New Cpu gpu miner playbook"

      assert_patch(index_live, ~p"/cpu_gpu_miner_playbooks/new")

      assert index_live
             |> form("#cpu_gpu_miner_playbook-form", cpu_gpu_miner_playbook: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#cpu_gpu_miner_playbook-form", cpu_gpu_miner_playbook: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/cpu_gpu_miner_playbooks")

      html = render(index_live)
      assert html =~ "Cpu gpu miner playbook created successfully"
      assert html =~ "some software_name"
    end

    test "updates cpu_gpu_miner_playbook in listing", %{conn: conn, cpu_gpu_miner_playbook: cpu_gpu_miner_playbook} do
      {:ok, index_live, _html} = live(conn, ~p"/cpu_gpu_miner_playbooks")

      assert index_live |> element("#cpu_gpu_miner_playbooks-#{cpu_gpu_miner_playbook.id} a", "Edit") |> render_click() =~
               "Edit Cpu gpu miner playbook"

      assert_patch(index_live, ~p"/cpu_gpu_miner_playbooks/#{cpu_gpu_miner_playbook}/edit")

      assert index_live
             |> form("#cpu_gpu_miner_playbook-form", cpu_gpu_miner_playbook: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#cpu_gpu_miner_playbook-form", cpu_gpu_miner_playbook: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/cpu_gpu_miner_playbooks")

      html = render(index_live)
      assert html =~ "Cpu gpu miner playbook updated successfully"
      assert html =~ "some updated software_name"
    end

    test "deletes cpu_gpu_miner_playbook in listing", %{conn: conn, cpu_gpu_miner_playbook: cpu_gpu_miner_playbook} do
      {:ok, index_live, _html} = live(conn, ~p"/cpu_gpu_miner_playbooks")

      assert index_live |> element("#cpu_gpu_miner_playbooks-#{cpu_gpu_miner_playbook.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#cpu_gpu_miner_playbooks-#{cpu_gpu_miner_playbook.id}")
    end
  end

  describe "Show" do
    setup [:create_cpu_gpu_miner_playbook]

    test "displays cpu_gpu_miner_playbook", %{conn: conn, cpu_gpu_miner_playbook: cpu_gpu_miner_playbook} do
      {:ok, _show_live, html} = live(conn, ~p"/cpu_gpu_miner_playbooks/#{cpu_gpu_miner_playbook}")

      assert html =~ "Show Cpu gpu miner playbook"
      assert html =~ cpu_gpu_miner_playbook.software_name
    end

    test "updates cpu_gpu_miner_playbook within modal", %{conn: conn, cpu_gpu_miner_playbook: cpu_gpu_miner_playbook} do
      {:ok, show_live, _html} = live(conn, ~p"/cpu_gpu_miner_playbooks/#{cpu_gpu_miner_playbook}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Cpu gpu miner playbook"

      assert_patch(show_live, ~p"/cpu_gpu_miner_playbooks/#{cpu_gpu_miner_playbook}/show/edit")

      assert show_live
             |> form("#cpu_gpu_miner_playbook-form", cpu_gpu_miner_playbook: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#cpu_gpu_miner_playbook-form", cpu_gpu_miner_playbook: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/cpu_gpu_miner_playbooks/#{cpu_gpu_miner_playbook}")

      html = render(show_live)
      assert html =~ "Cpu gpu miner playbook updated successfully"
      assert html =~ "some updated software_name"
    end
  end
end
