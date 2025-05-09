defmodule MiningRigMonitorWeb.CpuGpuMinerLiveTest do
  use MiningRigMonitorWeb.ConnCase

  import Phoenix.LiveViewTest
  import MiningRigMonitor.CpuGpuMinersFixtures

  alias MiningRigMonitor.AccountsFixtures
  require Logger

  @create_attrs %{name: "Thanh Long"}
  @update_attrs %{name: "Thanh Long 2"}
  @invalid_attrs_1 %{name: "T"}
  @invalid_attrs_2 %{name: ""}

  defp create_cpu_gpu_miner(_) do
    Logger.warning("[#{__MODULE__}] create_cpu_gpu_miner/1 deprecated")
    cpu_gpu_miner = cpu_gpu_miner_fixture()
    %{cpu_gpu_miner: cpu_gpu_miner}
  end

  defp create_not_activated_cpu_gpu_miner(_) do
    cpu_gpu_miner = cpu_gpu_miner_not_activated_fixture()
    %{cpu_gpu_miner_not_activated: cpu_gpu_miner}
  end

  defp create_activated_cpu_gpu_miner(_) do
    cpu_gpu_miner = cpu_gpu_miner_activated_fixture()
    %{cpu_gpu_miner_activated: cpu_gpu_miner}
  end

  defp login_user(%{conn: conn}) do
    conn_mod = log_in_user(conn, AccountsFixtures.user_fixture())
    %{conn: conn_mod}
  end

  describe "Index" do
    setup [:create_cpu_gpu_miner, :login_user, :create_not_activated_cpu_gpu_miner, :create_activated_cpu_gpu_miner]

    test "lists all cpu_gpu_miners",
      %{conn: conn, cpu_gpu_miner_not_activated: cpu_gpu_miner_not_activated, cpu_gpu_miner_activated: cpu_gpu_miner_activated} do
      {:ok, view, html} = live(conn, ~p"/cpu_gpu_miners")

      assert view.module == MiningRigMonitorWeb.CpuGpuMinerLive.Index
      assert html =~ "Activated CPU/GPU Miners"
      assert html =~ "New CPU/GPU miners waiting signals from sentry!"
      assert html =~ cpu_gpu_miner_not_activated.name
      assert html =~ cpu_gpu_miner_activated.name
    end

    test "redirect to /cpu_gpu_miners/new from index", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/cpu_gpu_miners")

      index_live
      |> element("a", "New CPU/GPU Miners")
      |> render_click()

      assert_redirect(index_live, ~p"/cpu_gpu_miners/new", 100)
    end

    test "redirect to cpu_gpu_miner edit page from index link",
      %{conn: conn, cpu_gpu_miner_activated: cpu_gpu_miner_activated,
        cpu_gpu_miner_not_activated: cpu_gpu_miner_not_activated} do

      {:ok, index_live_1, _html} = live(conn, ~p"/cpu_gpu_miners")

      index_live_1
      |> element("#cpu_gpu_miner-#{cpu_gpu_miner_activated.id}-edit")
      |> render_click()
      assert_redirect(index_live_1, ~p"/cpu_gpu_miners/#{cpu_gpu_miner_activated.id}/edit", 100)


      {:ok, index_live_2, _html} = live(conn, ~p"/cpu_gpu_miners")
      index_live_2
      |> element("#cpu_gpu_miner-#{cpu_gpu_miner_not_activated.id}-edit")
      |> render_click()
      assert_redirect(index_live_2, ~p"/cpu_gpu_miners/#{cpu_gpu_miner_not_activated.id}/edit", 100)
    end


    test "deletes activated cpu_gpu_miner in listing", %{conn: conn, cpu_gpu_miner_activated: cpu_gpu_miner} do
      {:ok, index_live, _html} = live(conn, ~p"/cpu_gpu_miners")

      assert has_element?(index_live, "#cpu_gpu_miner_activated_list-#{cpu_gpu_miner.id}")
      index_live
      |> element("#cpu_gpu_miner-#{cpu_gpu_miner.id}-delete")
      |> render_click()


      refute has_element?(index_live, "#cpu_gpu_miner_activated_list-#{cpu_gpu_miner.id}")
    end

    test "deletes not activated cpu_gpu_miner in listing", %{conn: conn, cpu_gpu_miner_not_activated: cpu_gpu_miner} do
      {:ok, index_live, _html} = live(conn, ~p"/cpu_gpu_miners")

      assert has_element?(index_live, "#cpu_gpu_miner_not_activated_list-#{cpu_gpu_miner.id}")

      index_live
      |> element("#cpu_gpu_miner-#{cpu_gpu_miner.id}-delete")
      |> render_click()


      refute has_element?(index_live, "#cpu_gpu_miner_not_activated_list-#{cpu_gpu_miner.id}")
    end
  end

  describe "New" do
    setup [:login_user]
    test "saves new cpu_gpu_miner", %{conn: conn} do
      {:ok, new_live, html} = live(conn, ~p"/cpu_gpu_miners/new")
      assert html =~ "Create new CPU/GPU Miners"

      new_live
      |> form("#cpu_gpu_miner_new_form", [cpu_gpu_miner: @invalid_attrs_1])
      |> render_change() =~ "should be at least 2 character(s)"

      new_live
      |> form("#cpu_gpu_miner_new_form", [cpu_gpu_miner: @invalid_attrs_2])
      |> render_change() =~ "can't be blank"

      new_live
      |> form("#cpu_gpu_miner_new_form", [cpu_gpu_miner: @create_attrs])
      |> render_submit()

      flash = assert_redirect(new_live, ~p"/cpu_gpu_miners", 100)
      assert Map.get(flash, "info") =~ "created successfully"

      {:ok, _index_live, html} = live(conn, ~p"/cpu_gpu_miners")
      assert html =~ "Thanh Long"
    end
  end

  describe "Edit" do
    setup [:login_user, :create_activated_cpu_gpu_miner, :create_not_activated_cpu_gpu_miner]

    test "updates cpu_gpu_miner in listing", %{conn: conn, cpu_gpu_miner_activated: cpu_gpu_miner} do
      {:ok, edit_live, edit_html} = live(conn, ~p"/cpu_gpu_miners/#{cpu_gpu_miner.id}/edit")
      assert edit_html =~ "Edit CPU/GPU Miners"

      edit_live
      |> form("#cpu_gpu_miner_edit_form", cpu_gpu_miner: @invalid_attrs_1)
      |> render_change =~ "should be at least 2 character(s)"

      edit_live
      |> form("#cpu_gpu_miner_edit_form", cpu_gpu_miner: @invalid_attrs_2)
      |> render_change =~ "can't be blank"

      edit_live
      |> form("#cpu_gpu_miner_edit_form", cpu_gpu_miner: @update_attrs)
      |> render_submit()

      flash = assert_redirect(edit_live, ~p"/cpu_gpu_miners", 100)
      assert Map.get(flash, "info") =~ "updated successfully"

      {:ok, _index_live, index_html} = live(conn, ~p"/cpu_gpu_miners")
      assert index_html =~ "Thanh Long 2"
    end
  end

  # describe "Show" do
  #   setup [:create_cpu_gpu_miner]

  #   test "displays cpu_gpu_miner", %{conn: conn, cpu_gpu_miner: cpu_gpu_miner} do
  #     {:ok, _show_live, html} = live(conn, ~p"/cpu_gpu_miners/#{cpu_gpu_miner}")

  #     assert html =~ "Show Cpu gpu miner"
  #     assert html =~ cpu_gpu_miner.name
  #   end

  #   test "updates cpu_gpu_miner within modal", %{conn: conn, cpu_gpu_miner: cpu_gpu_miner} do
  #     {:ok, show_live, _html} = live(conn, ~p"/cpu_gpu_miners/#{cpu_gpu_miner}")

  #     assert show_live |> element("a", "Edit") |> render_click() =~
  #              "Edit Cpu gpu miner"

  #     assert_patch(show_live, ~p"/cpu_gpu_miners/#{cpu_gpu_miner}/show/edit")

  #     assert show_live
  #            |> form("#cpu_gpu_miner-form", cpu_gpu_miner: @invalid_attrs)
  #            |> render_change() =~ "can&#39;t be blank"

  #     assert show_live
  #            |> form("#cpu_gpu_miner-form", cpu_gpu_miner: @update_attrs)
  #            |> render_submit()

  #     assert_patch(show_live, ~p"/cpu_gpu_miners/#{cpu_gpu_miner}")

  #     html = render(show_live)
  #     assert html =~ "Cpu gpu miner updated successfully"
  #     assert html =~ "some updated name"
  #   end
  # end
end
