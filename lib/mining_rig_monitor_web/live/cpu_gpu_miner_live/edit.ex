defmodule MiningRigMonitorWeb.CpuGpuMinerLive.Edit do
  use MiningRigMonitorWeb, :live_view_container_grow

  on_mount MiningRigMonitorWeb.UserAuthLive

  alias MiningRigMonitor.CpuGpuMiners.CpuGpuMiner
  alias MiningRigMonitor.CpuGpuMiners

  @impl true
  def mount(%{"id" => id}, _session, socket) do
    cpu_gpu_miner = CpuGpuMiners.get_cpu_gpu_miner!(id)

    form = cpu_gpu_miner
    |> CpuGpuMiner.changeset_edit_by_commander(%{})
    |> to_form()

    socket_mod = socket
    |> assign(:cpu_gpu_miner, cpu_gpu_miner)
    |> assign(:form, form)
    {:ok, socket_mod}
  end

  @impl true
  def handle_event("validate", %{"cpu_gpu_miner" => cpu_gpu_miner_params}, socket) do
    form = %CpuGpuMiner{}
    |> CpuGpuMiner.changeset_edit_by_commander(cpu_gpu_miner_params)
    |> to_form([action: :validate])

    socket_mod = socket
    |> assign(:form, form)
    {:noreply, socket_mod}
  end

  @impl true
  def handle_event("update", %{"cpu_gpu_miner" => cpu_gpu_miner_params}, socket) do
    cpu_gpu_miner = socket.assigns[:cpu_gpu_miner]
    case CpuGpuMiners.update_cpu_gpu_miner_by_commander(cpu_gpu_miner, cpu_gpu_miner_params) do
      {:ok, cpu_gpu_miner} ->
        Phoenix.PubSub.broadcast(MiningRigMonitor.PubSub, "cpu_gpu_miner_index_channel",
          {:cpu_gpu_miner_index_channel, :create_or_update, cpu_gpu_miner})
        Phoenix.PubSub.broadcast(MiningRigMonitor.PubSub, "cpu_gpu_miner_channel:#{cpu_gpu_miner.id}",
          {:cpu_gpu_miner_channel, :update, cpu_gpu_miner})

        flash_message = "CPU/GPU miner id##{cpu_gpu_miner.id} name: #{cpu_gpu_miner.name} updated successfully"
        Phoenix.PubSub.broadcast(MiningRigMonitor.PubSub, "flash_index",
          {:flash_index, :info, flash_message})

        socket_mod = socket
        |> put_flash(:info, flash_message)
        |> push_navigate(to: ~p"/cpu_gpu_miners")
        {:noreply, socket_mod}

      {:error, changeset} ->
        form = to_form(changeset, [action: :validate])
        socket_mod = socket
        |> assign(:form, form)
        {:noreply, socket_mod}
    end
  end
end
