defmodule MiningRigMonitorWeb.AsicMinerLive.FormComponent do
  use MiningRigMonitorWeb, :live_component

  alias MiningRigMonitor.AsicMiners

  @impl true
  def update(%{asic_miner: asic_miner} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(AsicMiners.change_asic_miner(asic_miner))
     end)}
  end

  @impl true
  def handle_event("validate", %{"asic_miner" => asic_miner_params}, socket) do
    changeset = AsicMiners.change_asic_miner(socket.assigns.asic_miner, asic_miner_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"asic_miner" => asic_miner_params}, socket) do
    save_asic_miner(socket, socket.assigns.action, asic_miner_params)
  end

  defp save_asic_miner(socket, :edit, asic_miner_params) do
    case AsicMiners.update_asic_miner_by_commander(socket.assigns.asic_miner, asic_miner_params) do
      {:ok, asic_miner} ->
        Phoenix.PubSub.broadcast(MiningRigMonitor.PubSub, "asic_miner_index_channel",
          {:asic_miner_index_channel, :create_or_update, asic_miner})
        Phoenix.PubSub.broadcast(MiningRigMonitor.PubSub, "asic_miner_channel:#{asic_miner.id}",
          {:asic_miner_channel, :update_asic_miner, asic_miner})
        Phoenix.PubSub.broadcast(MiningRigMonitor.PubSub, "flash_index",
          {:flash_index, :info, "ASIC miner id##{asic_miner.id} name: #{asic_miner.name} updated successfully!"})
        socket_mod = push_patch(socket, to: socket.assigns.patch)
        {:noreply, socket_mod}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_asic_miner(socket, :new, asic_miner_params) do
    case AsicMiners.create_asic_miner_by_commander(asic_miner_params) do
      {:ok, asic_miner} ->
        Phoenix.PubSub.broadcast(MiningRigMonitor.PubSub, "asic_miner_index_channel",
          {:asic_miner_index_channel, :create_or_update, asic_miner})
        Phoenix.PubSub.broadcast(MiningRigMonitor.PubSub, "flash_index",
          {:flash_index, :info, "ASIC miner id##{asic_miner.id} name: #{asic_miner.name} created successfully!"})

        socket_mod = push_patch(socket, to: socket.assigns.patch)
        {:noreply, socket_mod}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
