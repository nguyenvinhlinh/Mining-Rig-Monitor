defmodule MiningRigMonitorWeb.CpuGpuMinerLive.FormComponent do
  use MiningRigMonitorWeb, :live_component

  alias MiningRigMonitor.CpuGpuMiners

  @impl true
  def update(%{cpu_gpu_miner: cpu_gpu_miner} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(CpuGpuMiners.change_cpu_gpu_miner(cpu_gpu_miner))
     end)}
  end

  @impl true
  def handle_event("validate", %{"cpu_gpu_miner" => cpu_gpu_miner_params}, socket) do
    changeset = CpuGpuMiners.change_cpu_gpu_miner(socket.assigns.cpu_gpu_miner, cpu_gpu_miner_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"cpu_gpu_miner" => cpu_gpu_miner_params}, socket) do
    save_cpu_gpu_miner(socket, socket.assigns.action, cpu_gpu_miner_params)
  end

  defp save_cpu_gpu_miner(socket, :edit, cpu_gpu_miner_params) do
    case CpuGpuMiners.update_cpu_gpu_miner(socket.assigns.cpu_gpu_miner, cpu_gpu_miner_params) do
      {:ok, cpu_gpu_miner} ->
        notify_parent({:saved, cpu_gpu_miner})

        {:noreply,
         socket
         |> put_flash(:info, "Cpu gpu miner updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_cpu_gpu_miner(socket, :new, cpu_gpu_miner_params) do
    case CpuGpuMiners.create_cpu_gpu_miner(cpu_gpu_miner_params) do
      {:ok, cpu_gpu_miner} ->
        notify_parent({:saved, cpu_gpu_miner})

        {:noreply,
         socket
         |> put_flash(:info, "Cpu gpu miner created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
