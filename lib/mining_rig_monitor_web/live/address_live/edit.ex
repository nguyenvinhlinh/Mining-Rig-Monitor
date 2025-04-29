defmodule MiningRigMonitorWeb.AddressLive.Edit do
  use MiningRigMonitorWeb, :live_view_container_grow

  on_mount MiningRigMonitorWeb.UserAuthLive
  alias MiningRigMonitor.Addresses.Address
  alias MiningRigMonitor.Addresses

  @impl true
  def mount(%{"id" => id}, session, socket) do
    address = Addresses.get_address!(id)
    form = address
    |> Address.changeset_update(%{})
    |> to_form()

    socket_mod = socket
    |> assign(:address, address)
    |> assign(:form, form)
    {:ok, socket_mod}
  end

  @impl true
  def handle_params(params, url, socket) do
    {:noreply, socket}
  end

  @imple true
  def handle_event("validate", %{"address" => address_params}, socket) do
    form = %Address{}
    |> Address.changeset_update(address_params)
    |> to_form([action: :validate])

    socket_mod = socket
    |> assign(:form, form)

    {:noreply, socket_mod}
  end

  def handle_event("update", %{"address" => address_params}, socket) do
    address = socket.assigns[:address]
    case Addresses.update_address(address, address_params) do
      {:ok, address} ->
        flash_message = "Updated #{address.type} address, #{address.name}"
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
end
