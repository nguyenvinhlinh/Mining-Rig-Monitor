defmodule MiningRigMonitorWeb.AddressLive.Index do
  use MiningRigMonitorWeb, :live_view_container_grow

  alias MiningRigMonitor.Addresses
  alias MiningRigMonitor.Addresses.Address

  embed_templates "index_html/*"
  on_mount MiningRigMonitorWeb.UserAuthLive

  @impl true
  def mount(_params, _session, socket) do
    wallet_address_list = Addresses.list_addresses_by_type(Address.type_wallet())
    pool_address_list =   Addresses.list_addresses_by_type(Address.type_pool())
    socket_mod = socket
    |> stream(:wallet_address_list, wallet_address_list)
    |> stream(:pool_address_list, pool_address_list)

    {:ok, socket_mod}
  end

  @impl true
  def handle_params(_params, _url, socket) do
    socket_mod = socket
    |> assign(:page_title, "Listing Addresses")
    |> assign(:address, nil)
    {:noreply, socket_mod}
  end

  @impl true
  def handle_info({MiningRigMonitorWeb.AddressLive.FormComponent, {:saved, address}}, socket) do
    case address.type do
      "wallet" ->
        socket_mod = socket
        |> stream_insert(:wallet_address_list, address)
        |> stream_delete(:pool_address_list, address)
        {:noreply, socket_mod}
      "pool" ->
        socket_mod = socket
        |> stream_insert(:pool_address_list, address)
        |> stream_delete(:wallet_address_list, address)
        {:noreply, socket_mod}
    end
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    address = Addresses.get_address!(id)
    {:ok, _} = Addresses.delete_address(address)

    socket_mod = socket
    |> stream_delete(:pool_address_list, address)
    |> stream_delete(:wallet_address_list, address)

    {:noreply, socket_mod}
  end
end
