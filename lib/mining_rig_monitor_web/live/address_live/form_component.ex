defmodule MiningRigMonitorWeb.AddressLive.FormComponent do
  use MiningRigMonitorWeb, :live_component

  alias MiningRigMonitor.Addresses
  alias MiningRigMonitor.Addresses.Address

  @impl true
  def update(%{address: address} = assigns, socket) do
    address_type_option_list = [
      "Pool Address":   Address.type_pool(),
      "Wallet Address": Address.type_wallet()
    ]

    socket_mod = socket
    |> assign(assigns)
    |> assign_new(:form, fn ->
      to_form(Addresses.change_address(address))
    end)
    |> assign(:address_type_option_list, address_type_option_list)
    {:ok, socket_mod}
end

  @impl true
  def handle_event("validate", %{"address" => address_params}, socket) do
    changeset = Addresses.change_address(socket.assigns.address, address_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"address" => address_params}, socket) do
    save_address(socket, socket.assigns.action, address_params)
  end

  defp save_address(socket, :edit, address_params) do
    case Addresses.update_address(socket.assigns.address, address_params) do
      {:ok, address} ->
        notify_parent({:saved, address})

        {:noreply,
         socket
         |> put_flash(:info, "Address updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_address(socket, :new, address_params) do
    case Addresses.create_address(address_params) do
      {:ok, address} ->
        notify_parent({:saved, address})

        {:noreply,
         socket
         |> put_flash(:info, "Address created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
