defmodule MiningRigMonitorWeb.CpuGpuMinerLive.FormComponent do
  use MiningRigMonitorWeb, :live_component

  alias MiningRigMonitor.CpuGpuMiners

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        {@title}
        <:subtitle>Use this form to manage cpu_gpu_miner records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="cpu_gpu_miner-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:name]} type="text" label="Name" />
        <.input field={@form[:api_code]} type="text" label="Api code" />
        <.input field={@form[:cpu_1_name]} type="text" label="Cpu 1 name" />
        <.input field={@form[:cpu_2_name]} type="text" label="Cpu 2 name" />
        <.input field={@form[:ram_size]} type="text" label="Ram size" />
        <.input field={@form[:gpu_1_name]} type="text" label="Gpu 1 name" />
        <.input field={@form[:gpu_2_name]} type="text" label="Gpu 2 name" />
        <.input field={@form[:gpu_3_name]} type="text" label="Gpu 3 name" />
        <.input field={@form[:gpu_4_name]} type="text" label="Gpu 4 name" />
        <.input field={@form[:gpu_5_name]} type="text" label="Gpu 5 name" />
        <.input field={@form[:gpu_6_name]} type="text" label="Gpu 6 name" />
        <.input field={@form[:gpu_7_name]} type="text" label="Gpu 7 name" />
        <.input field={@form[:gpu_8_name]} type="text" label="Gpu 8 name" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Cpu gpu miner</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

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
