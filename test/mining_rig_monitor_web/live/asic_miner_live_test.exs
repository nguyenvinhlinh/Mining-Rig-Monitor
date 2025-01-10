defmodule MiningRigMonitorWeb.AsicMinerLiveTest do
  use MiningRigMonitorWeb.ConnCase

  import Phoenix.LiveViewTest
  import MiningRigMonitor.AsicMinersFixtures
  import MiningRigMonitor.AccountsFixtures

  @create_attrs %{name: "KS5L-1"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  defp create_asic_miner_by_commander(_) do
    asic_miner = asic_miner_fixture_by_commander()
    %{asic_miner: asic_miner}
  end


  describe "Index" do
    setup [:create_asic_miner_by_commander]

    test "lists all asic_miners", %{conn: conn, asic_miner: asic_miner} do
      {:ok, _index_live, html} = conn
      |> log_in_user(user_fixture())
      |> live(~p"/asic_miners")

      assert html =~ "ASIC Miner Index"
      assert html =~ asic_miner.name
      assert html =~ asic_miner.api_code
    end

    test "saves new asic_miner", %{conn: conn} do
      {:ok, index_live, _html} = conn
      |> log_in_user(user_fixture())
      |> live(~p"/asic_miners")

      assert index_live |> element("a", "New ASIC Miner") |> render_click() =~
               "New ASIC Miner"

      assert_patch(index_live, ~p"/asic_miners/new")

      assert index_live
             |> form("#asic_miner-form", asic_miner: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#asic_miner-form", asic_miner: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/asic_miners")

      html = render(index_live)
      assert html =~ "created successfully!"
      assert html =~ "KS5L-1"
    end

    test "updates asic_miner in listing", %{conn: conn, asic_miner: asic_miner} do
      {:ok, index_live, _html} = conn
      |> log_in_user(user_fixture())
      |> live(~p"/asic_miners")

      assert index_live |> element("#asic_miner_not_activated_list-#{asic_miner.id}  a", "Edit") |> render_click() =~
               "Edit ASIC miner"

      assert_patch(index_live, ~p"/asic_miners/#{asic_miner}/edit")

      assert index_live
             |> form("#asic_miner-form", asic_miner: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#asic_miner-form", asic_miner: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/asic_miners")

      html = render(index_live)
      assert html =~ "updated successfully!"
      assert html =~ "some updated name"
    end

    test "deletes asic_miner in listing", %{conn: conn, asic_miner: asic_miner} do
      {:ok, index_live, _html} = conn
      |> log_in_user(user_fixture())
      |> live(~p"/asic_miners")

      assert index_live |> element("#asic_miner_not_activated_list-#{asic_miner.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#asic_miners-#{asic_miner.id}")
    end
  end

  describe "Show" do
    setup [:create_asic_miner_by_commander]

    test "displays asic_miner", %{conn: conn, asic_miner: asic_miner} do
      {:ok, _show_live, html} = conn
      |> log_in_user(user_fixture())
      |> live(~p"/asic_miners/#{asic_miner}")

      assert html =~ "Show Asic miner"
      assert html =~ asic_miner.name
    end

    test "updates asic_miner within modal", %{conn: conn, asic_miner: asic_miner} do
      {:ok, show_live, _html} = live(conn, ~p"/asic_miners/#{asic_miner}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Asic miner"

      assert_patch(show_live, ~p"/asic_miners/#{asic_miner}/show/edit")

      assert show_live
             |> form("#asic_miner-form", asic_miner: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#asic_miner-form", asic_miner: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/asic_miners/#{asic_miner}")

      html = render(show_live)
      assert html =~ "Asic miner updated successfully"
      assert html =~ "some updated name"
    end
  end
end
