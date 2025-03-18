defmodule MiningRigMonitorWeb.CpuGpuMinerPlaybookLive.FormComponent do
  use MiningRigMonitorWeb, :live_component

  alias MiningRigMonitor.CpuGpuMinerPlaybooks

  @impl true
  def update(%{cpu_gpu_miner_playbook: cpu_gpu_miner_playbook} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(CpuGpuMinerPlaybooks.change_cpu_gpu_miner_playbook(cpu_gpu_miner_playbook))
     end)}
  end

  @impl true
  def handle_event("validate", %{"cpu_gpu_miner_playbook" => cpu_gpu_miner_playbook_params}, socket) do
    changeset = CpuGpuMinerPlaybooks.change_cpu_gpu_miner_playbook(socket.assigns.cpu_gpu_miner_playbook, cpu_gpu_miner_playbook_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"cpu_gpu_miner_playbook" => cpu_gpu_miner_playbook_params}, socket) do
    save_cpu_gpu_miner_playbook(socket, socket.assigns.action, cpu_gpu_miner_playbook_params)
  end

  defp save_cpu_gpu_miner_playbook(socket, :edit, cpu_gpu_miner_playbook_params) do
    case CpuGpuMinerPlaybooks.update_cpu_gpu_miner_playbook(socket.assigns.cpu_gpu_miner_playbook, cpu_gpu_miner_playbook_params) do
      {:ok, cpu_gpu_miner_playbook} ->
        notify_parent({:saved, cpu_gpu_miner_playbook})

        {:noreply,
         socket
         |> put_flash(:info, "Cpu gpu miner playbook updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_cpu_gpu_miner_playbook(socket, :new, cpu_gpu_miner_playbook_params) do
    cpu_gpu_miner = socket.assigns.cpu_gpu_miner
    cpu_gpu_miner_playbook_params_mod = cpu_gpu_miner_playbook_params
    |> Map.put("cpu_gpu_miner_id", cpu_gpu_miner.id)

    case CpuGpuMinerPlaybooks.create_cpu_gpu_miner_playbook(cpu_gpu_miner_playbook_params_mod) do
      {:ok, cpu_gpu_miner_playbook} ->
        notify_parent({:saved, cpu_gpu_miner_playbook})

        {:noreply,
         socket
         |> put_flash(:info, "CPU/GPU miner playbook created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
