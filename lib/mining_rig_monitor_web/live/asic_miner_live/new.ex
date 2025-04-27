defmodule MiningRigMonitorWeb.AsicMinerLive.New do
  use MiningRigMonitorWeb, :live_view_container_grow
  alias MiningRigMonitor.AsicMiners.AsicMiner
  alias MiningRigMonitor.AsicMiners

  on_mount MiningRigMonitorWeb.UserAuthLive

  @impl true
  def mount(_params, _session, socket) do
    form = %AsicMiner{}
    |> AsicMiner.changeset_new_by_commander(%{})
    |> to_form()

    socket_mod = socket
    |> assign(:form, form)
    {:ok, socket_mod}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, socket}
  end

  @impl true
  def handle_event("validate", %{"asic_miner" => asic_miner_params}, socket) do
    form = %AsicMiner{}
    |> AsicMiner.changeset_new_by_commander(asic_miner_params)
    |> to_form([action: :validate])

    socket_mod = socket
    |> assign(:form, form)
    {:noreply, socket_mod}
  end

  def handle_event("save", %{"asic_miner" => asic_miner_params}, socket) do
    case AsicMiners.create_asic_miner_by_commander(asic_miner_params) do
      {:ok, asic_miner} ->
        Phoenix.PubSub.broadcast(MiningRigMonitor.PubSub, "asic_miner_index_channel",
          {:asic_miner_index_channel, :create_or_update, asic_miner})
        message = "ASIC miner id##{asic_miner.id} name: #{asic_miner.name} created successfully!"
        Phoenix.PubSub.broadcast(MiningRigMonitor.PubSub, "flash_index",
          {:flash_index, :info, message})

        socket_mod = socket
        |> put_flash(:info, message)
        |> push_navigate(to: ~p"/asic_miners")
        {:noreply, socket_mod}
      {:error, %Ecto.Changeset{} = changeset} ->
        form = to_form(changeset)
        socket_mod = socket
        |> assign(:form, form)
        {:noreply, socket_mod}

    end
  end
end
