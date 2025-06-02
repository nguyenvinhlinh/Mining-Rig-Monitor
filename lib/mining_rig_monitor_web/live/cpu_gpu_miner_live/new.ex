defmodule MiningRigMonitorWeb.CpuGpuMinerLive.New do
  use MiningRigMonitorWeb, :live_view_container_grow

  on_mount MiningRigMonitorWeb.UserAuthLive

  alias MiningRigMonitor.CpuGpuMiners.CpuGpuMiner
  alias MiningRigMonitor.CpuGpuMiners

  @impl true
  def mount(_params, _session, socket) do
    form = %CpuGpuMiner{}
    |> CpuGpuMiner.changeset_new_by_commander(%{})
    |> to_form()

    socket_mod = socket
    |> assign(:form, form )
    {:ok, socket_mod}
  end

  @impl true
  def handle_event("validate", %{"cpu_gpu_miner" => cpu_gpu_miner_params}, socket) do
    form = %CpuGpuMiner{}
    |> CpuGpuMiner.changeset_new_by_commander(cpu_gpu_miner_params)
    |> to_form([action: :validate])

    socket_mod = socket
    |> assign(:form, form)
    {:noreply, socket_mod}
  end

  @impl true
  def handle_event("save", %{"cpu_gpu_miner" => cpu_gpu_miner_params}, socket) do
    cpu_gpu_miner_params_mod = cpu_gpu_miner_params
    |> Map.put("api_code", UUID.uuid1())
    |> Map.put("activated", false)

    case CpuGpuMiners.create_cpu_gpu_miner_by_commander(cpu_gpu_miner_params_mod) do
      {:ok, cpu_gpu_miner} ->
        Phoenix.PubSub.broadcast(MiningRigMonitor.PubSub, "cpu_gpu_miner_index_channel",
          {:cpu_gpu_miner_index_channel, :create_or_update, cpu_gpu_miner})
        flash_message = "CPU/GPU miner id##{cpu_gpu_miner.id} name: #{cpu_gpu_miner.name} created successfully"
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
