defmodule MiningRigMonitorWeb.AddressLive.New do
  use MiningRigMonitorWeb, :live_view_container_grow

  on_mount MiningRigMonitorWeb.UserAuthLive
  alias MiningRigMonitor.Addresses.Address
  alias MiningRigMonitor.Addresses

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(params, _url, socket) do
    apply_action(socket, socket.assigns.live_action, params)
  end

  @impl true
  def handle_event("validate", %{"address" => address_params}, socket) do
    form = %Address{}
    |> Address.changeset_new(address_params)
    |> to_form([action: :validate])

    socket_mod = socket
    |> assign(:form, form)

    {:noreply, socket_mod}
  end

  @impl true
  def handle_event("save", %{"address" => address_params}, socket) do
    address_params_mod =
      case socket.assigns.live_action do
        :new_wallet -> Map.put(address_params, "type", Address.type_wallet())
        :new_pool ->   Map.put(address_params, "type", Address.type_pool())
        _ ->           address_params
      end

    case Addresses.create_address(address_params_mod) do
      {:ok, address} ->
        flash_message = "Created new #{address.type} address, #{address.name}"
        socket_mod = socket
        |> put_flash(:info, flash_message)
        |> push_navigate(to: ~p"/addresses")
        {:noreply, socket_mod}

      {:error, changeset} ->
        form = to_form(changeset)
        flash_message = "Please fix error before save"
        socket_mod = socket
        |> assign(:form, form)
        |> put_flash(:error, flash_message)
        {:noreply, socket_mod}
    end
  end


  defp apply_action(socket, :new_wallet, _params) do
    form = %Address{}
    |> Address.changeset_new(%{type: "wallet"})
    |> to_form()

    socket_mod = socket
    |> assign(:address_type, "wallet")
    |> assign(:form, form)

    {:noreply, socket_mod}
  end

  defp apply_action(socket, :new_pool, _params) do
    form = %Address{}
    |> Address.changeset_new(%{type: "pool"})
    |> to_form()

    socket_mod = socket
    |> assign(:address_type, "pool")
    |> assign(:form, form)

    {:noreply, socket_mod}
  end


end
