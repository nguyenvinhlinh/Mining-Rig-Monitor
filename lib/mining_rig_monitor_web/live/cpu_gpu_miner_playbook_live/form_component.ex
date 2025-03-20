defmodule MiningRigMonitorWeb.CpuGpuMinerPlaybookLive.FormComponent do
  use MiningRigMonitorWeb, :live_component

  alias MiningRigMonitor.CpuGpuMinerPlaybooks
  alias MiningRigMonitor.CpuGpuMinerPlaybooks.CpuGpuMinerPlaybook

  @impl true
  def update(%{cpu_gpu_miner_playbook: cpu_gpu_miner_playbook, action: :new} = assigns, socket) do
    software_name_option_list = CpuGpuMinerPlaybook.get_software_name_list()
    software_version_option_list = CpuGpuMinerPlaybook.get_software_version_list_by_name("XMRig")

    socket_mod = socket
    |> assign(assigns)
    |> assign(:software_name_option_list,    software_name_option_list)
    |> assign(:software_version_option_list, software_version_option_list)
    |> assign_new(:form, fn ->
      to_form(CpuGpuMinerPlaybooks.change_cpu_gpu_miner_playbook(cpu_gpu_miner_playbook))
    end)

    {:ok, socket_mod}
  end

  @impl true
  def update(%{cpu_gpu_miner_playbook: cpu_gpu_miner_playbook, action: :edit} = assigns, socket) do
    software_name_option_list = CpuGpuMinerPlaybook.get_software_name_list()
    software_version_option_list = CpuGpuMinerPlaybook.get_software_version_list_by_name(cpu_gpu_miner_playbook.software_name)

    socket_mod = socket
    |> assign(assigns)
    |> assign(:software_name_option_list,    software_name_option_list)
    |> assign(:software_version_option_list, software_version_option_list)
    |> assign_new(:form, fn ->
      to_form(CpuGpuMinerPlaybooks.change_cpu_gpu_miner_playbook(cpu_gpu_miner_playbook))
    end)

    {:ok, socket_mod}
  end

  @impl true
  def handle_event("validate", %{"cpu_gpu_miner_playbook" => cpu_gpu_miner_playbook_params}, socket) do

    params_software_name = Map.get(cpu_gpu_miner_playbook_params, "software_name")
    software_version_option_list = CpuGpuMinerPlaybook.get_software_version_list_by_name(params_software_name)
    IO.inspect "DEBUG #{__ENV__.file} @#{__ENV__.line}"
    IO.inspect :validate_function_call
    IO.inspect cpu_gpu_miner_playbook_params
    IO.inspect "END"


    changeset = CpuGpuMinerPlaybooks.change_cpu_gpu_miner_playbook(socket.assigns.cpu_gpu_miner_playbook, cpu_gpu_miner_playbook_params)
    form = to_form(changeset, action: :validate)
    socket_mod = socket
    |> assign(:form, form)
    |> assign(:software_version_option_list, software_version_option_list)

    {:noreply, socket_mod}
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
