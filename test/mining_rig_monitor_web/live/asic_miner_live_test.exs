defmodule MiningRigMonitorWeb.AsicMinerLiveTest do
  use MiningRigMonitorWeb.ConnCase

  import Phoenix.LiveViewTest
  import MiningRigMonitor.AsicMinersFixtures
  import MiningRigMonitor.AccountsFixtures
  alias  MiningRigMonitor.AsicMiners
  require Logger

  @create_attrs %{name: "KS5L-1"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

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



  # test "saves new asic_miner", %{conn: conn} do
    #   {:ok, index_live, _html} = conn
    #   |> log_in_user(user_fixture())
    #   |> live(~p"/asic_miners")

    #   assert index_live |> element("a", "New ASIC Miner") |> render_click() =~
    #            "New ASIC Miner"

    #   assert_patch(index_live, ~p"/asic_miners/new")

    #   assert index_live
    #          |> form("#asic_miner-form", asic_miner: @invalid_attrs)
    #          |> render_change() =~ "can&#39;t be blank"

    #   assert index_live
    #          |> form("#asic_miner-form", asic_miner: @create_attrs)
    #          |> render_submit()

    #   assert_patch(index_live, ~p"/asic_miners")

    #   html = render(index_live)
    #   assert html =~ "created successfully!"
    #   assert html =~ "KS5L-1"
    # end

    # test "updates asic_miner in listing", %{conn: conn, asic_miner: asic_miner} do
    #   {:ok, index_live, _html} = conn
    #   |> log_in_user(user_fixture())
    #   |> live(~p"/asic_miners")

    #   assert index_live |> element("#asic_miner_not_activated_list-#{asic_miner.id}  a", "Edit") |> render_click() =~
    #            "Edit ASIC miner"

    #   assert_patch(index_live, ~p"/asic_miners/#{asic_miner}/edit")

    #   assert index_live
    #          |> form("#asic_miner-form", asic_miner: @invalid_attrs)
    #          |> render_change() =~ "can&#39;t be blank"

    #   assert index_live
    #          |> form("#asic_miner-form", asic_miner: @update_attrs)
    #          |> render_submit()

    #   assert_patch(index_live, ~p"/asic_miners")

    #   html = render(index_live)
    #   assert html =~ "updated successfully!"
    #   assert html =~ "some updated name"
    # end



  describe "Show" do
    setup [:create_asic_miner_by_commander]

    test "displays asic_miner", %{conn: conn, asic_miner: asic_miner} do
      {:ok, _show_live, html} = conn
      |> log_in_user(user_fixture())
      |> live(~p"/asic_miners/#{asic_miner}")

      assert html =~ "General Information"
      assert html =~ "Hashrate"
      assert html =~ "Fan Speed"
      assert html =~ "Mining Pool"
      assert html =~ asic_miner.name
    end
  end

  describe "Edit" do
    test "edit page", do: nil
  end

  describe "New" do
    test "edit page", do: nil
  end
end
