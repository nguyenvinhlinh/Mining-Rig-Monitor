defmodule MiningRigMonitorWeb.AsicMinerLiveTest do
  use MiningRigMonitorWeb.ConnCase

  import Phoenix.LiveViewTest
  import MiningRigMonitor.AsicMinersFixtures
  import MiningRigMonitor.AccountsFixtures
  alias  MiningRigMonitor.AsicMiners
  require Logger

  @create_attrs %{name: "KS5L-1"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs_1 %{name: nil}
  @invalid_attrs_2 %{name: "K"}

  defp create_asic_miner_by_commander(_) do
    Logger.warning("[#{__MODULE__}] create_asic_miner_by_commander/1 deprecated")
    asic_miner = asic_miner_fixture_by_commander()
    %{asic_miner: asic_miner}
  end

  defp create_not_activated_asic_miner(_) do
    asic_miner = asic_miner_not_activated_fixture()
    %{asic_miner_not_activated: asic_miner}
  end

  defp create_activated_asic_miner(_) do
    asic_miner = asic_miner_activated_fixture()
    %{asic_miner_activated: asic_miner}
  end

  defp login_user(%{conn: conn}) do
   conn_mod = conn
   |> log_in_user(user_fixture())
   %{conn: conn_mod}
  end

  describe "Test redirect to login page if not login" do
    test "go to /asic_miners without login, redirect to login page", %{conn: conn} do
      assert {:error, {:redirect, %{to: "/users/log_in"}}} = live(conn, ~p"/asic_miners")
    end

    test "go to /asic_miners/:id without login, redirect to login page", %{conn: conn} do
      asic_miner = asic_miner_not_activated_fixture()
      assert {:error, {:redirect, %{to: "/users/log_in"}}} = live(conn, ~p"/asic_miners/#{asic_miner.id}")
    end

    test "go to /asic_miners/:id/edit without login, redirect to login page", %{conn: conn} do
      asic_miner = asic_miner_not_activated_fixture()
      assert {:error, {:redirect, %{to: "/users/log_in"}}} = live(conn, ~p"/asic_miners/#{asic_miner.id}/edit")
    end
  end


  describe "Index" do
    setup [:create_not_activated_asic_miner, :create_activated_asic_miner, :login_user]

    test "lists all asic_miners",
      %{conn: conn, asic_miner_not_activated: asic_miner_not_activated,
        asic_miner_activated: asic_miner_activated} do
      {:ok, _index_live, html} = live(conn, ~p"/asic_miners")

      assert html =~ "Thanh Long"
      assert html =~ "Bach Ho"
      assert html =~ asic_miner_not_activated.name
      assert html =~ asic_miner_not_activated.api_code
      assert html =~ asic_miner_activated.name
    end

    test "redirect to new page", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/asic_miners")
      index_live
      |> element("#asic_miners_new")
      |> render_click()

      assert_redirect index_live, ~p"/asic_miners/new", 100
    end

    test "redirect to edit page",
      %{conn: conn, asic_miner_not_activated: asic_miner_not_activated,
        asic_miner_activated: asic_miner_activated} do

      {:ok, index_live_1, _html} = live(conn, ~p"/asic_miners")
      index_live_1
      |> element("#asic_miner-#{asic_miner_activated.id}-edit")
      |> render_click()
      assert_redirect(index_live_1, ~p"/asic_miners/#{asic_miner_activated.id}/edit", 100)

      {:ok, index_live_2, _html} = live(conn, ~p"/asic_miners")
      index_live_2
      |> element("#asic_miner-#{asic_miner_not_activated.id}-edit")
      |> render_click()
      assert_redirect(index_live_2, ~p"/asic_miners/#{asic_miner_not_activated.id}/edit", 100)
    end

    test "redirect to show page",
      %{conn: conn,  asic_miner_activated: asic_miner_activated} do

      {:ok, index_live, _html} = live(conn, ~p"/asic_miners")
      index_live
      |> element("#asic_miner-#{asic_miner_activated.id}-show")
      |> render_click()
      assert_redirect(index_live, ~p"/asic_miners/#{asic_miner_activated.id}", 100)
    end

    test "deletes asic_miner in activated listing",
      %{conn: conn, asic_miner_activated: asic_miner_activated} do

      {:ok, index_live, _html} = live(conn, ~p"/asic_miners")
      assert has_element?(index_live, "#asic_miner_activated_list-#{asic_miner_activated.id}")
      index_live
      |> element("#asic_miner-#{asic_miner_activated.id}-delete")
      |> render_click()
      refute has_element?(index_live, "#asic_miner_activated_list-#{asic_miner_activated.id}")
    end

    test "deletes asic_miner in not activated listing",
      %{conn: conn, asic_miner_not_activated: asic_miner_not_activated} do
      {:ok, index_live, _html} = live(conn, ~p"/asic_miners")
      assert has_element?(index_live, "#asic_miner_not_activated_list-#{asic_miner_not_activated.id}")
      index_live
      |> element("#asic_miner-#{asic_miner_not_activated.id}-delete")
      |> render_click()
      refute has_element?(index_live, "#asic_miner_not_activated_list-#{asic_miner_not_activated.id}")
    end

    test "toggle asic expected status",
      %{conn: conn, asic_miner_activated: asic_miner_activated} do
      {:ok, index_live, html} = live(conn, ~p"/asic_miners")

      index_live
      |> element("#asic_miner-#{asic_miner_activated.id}-asic_toggle")
      |> render_click()

      after_toggle_asic_expected_status = if(asic_miner_activated.asic_expected_status == "on", do: "off", else: "on")
      updated_asic_miner_activated = AsicMiners.get_asic_miner!(asic_miner_activated.id)
      assert updated_asic_miner_activated.asic_expected_status == after_toggle_asic_expected_status
    end

    test "toggle light expected status",
      %{conn: conn, asic_miner_activated: asic_miner_activated} do
      {:ok, index_live, html} = live(conn, ~p"/asic_miners")

      index_live
      |> element("#asic_miner-#{asic_miner_activated.id}-light_toggle")
      |> render_click()

      after_toggle_light_expected_status = if(asic_miner_activated.light_expected_status == "on", do: "off", else: "on")
      updated_asic_miner_activated = AsicMiners.get_asic_miner!(asic_miner_activated.id)
      assert updated_asic_miner_activated.light_expected_status == after_toggle_light_expected_status
    end
  end

  describe "Show" do
    setup [:login_user, :create_activated_asic_miner]

    test "displays asic_miner", %{conn: conn, asic_miner_activated: asic_miner_activated} do
      {:ok, _show_live, html} = live(conn, ~p"/asic_miners/#{asic_miner_activated.id}")

      assert html =~ asic_miner_activated.name
      assert html =~ asic_miner_activated.api_code
      assert html =~ asic_miner_activated.firmware_version
      assert html =~ asic_miner_activated.software_version
      assert html =~ asic_miner_activated.model
      assert html =~ asic_miner_activated.model_variant
    end
  end

  describe "New" do
    setup [:login_user]

    test "create new asic_miner", %{conn: conn} do
      {:ok, new_live, new_html} = live(conn, ~p"/asic_miners/new")
      assert new_html =~ "Create new ASIC Miners"

      assert new_live
      |> form("#asic_miner_new_form", asic_miner: @invalid_attrs_1)
      |> render_change() =~ "can&#39;t be blank"

      assert new_live
      |> form("#asic_miner_new_form", asic_miner: @invalid_attrs_2)
      |> render_change() =~ "should be at least 2 character(s)"

     new_live
     |> form("#asic_miner_new_form", asic_miner: @create_attrs)
     |> render_submit()

     assert_redirect(new_live, ~p"/asic_miners", 100)

     {:ok, _index_live, index_html} = live(conn, ~p"/asic_miners")
     assert index_html =~ "KS5L-1"
    end
  end

  describe "Edit" do
    setup [:login_user, :create_activated_asic_miner]
    test "edit asic miner",
      %{conn: conn, asic_miner_activated: asic_miner} do
      {:ok, edit_live, edit_html} = live(conn, ~p"/asic_miners/#{asic_miner.id}/edit")
      assert edit_html =~ asic_miner.name

      assert edit_live
      |> form("#asic_miner_edit_form", asic_miner: @invalid_attrs_1)
      |> render_change() =~ "can&#39;t be blank"

      assert edit_live
      |> form("#asic_miner_edit_form", asic_miner: @invalid_attrs_2)
      |> render_change() =~ "should be at least 2 character(s)"

      edit_live
      |> form("#asic_miner_edit_form", asic_miner: @create_attrs)
      |> render_submit()

      assert_redirect(edit_live, ~p"/asic_miners", 100)
      {:ok, _index_live, index_html} = live(conn, ~p"/asic_miners")
      assert index_html =~ "KS5L-1"
    end
  end
end
