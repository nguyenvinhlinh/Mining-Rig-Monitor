defmodule MiningRigMonitorWeb.AsicMinerLive.FormComponent do
  use MiningRigMonitorWeb, :live_component

  alias MiningRigMonitor.AsicMiners

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        {@title}
        <:subtitle>Use this form to manage asic_miner records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="asic_miner-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:name]} type="text" label="Name" />
        <.input field={@form[:api_code]} type="text" label="Api code" />
        <.input field={@form[:firmware_version]} type="text" label="Firmware version" />
        <.input field={@form[:software_version]} type="text" label="Software version" />
        <.input field={@form[:model]} type="text" label="Model" />
        <.input field={@form[:model_variant]} type="text" label="Model variant" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Asic miner</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

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
    case AsicMiners.update_asic_miner(socket.assigns.asic_miner, asic_miner_params) do
      {:ok, asic_miner} ->
        notify_parent({:saved, asic_miner})

        {:noreply,
         socket
         |> put_flash(:info, "Asic miner updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_asic_miner(socket, :new, asic_miner_params) do
    case AsicMiners.create_asic_miner(asic_miner_params) do
      {:ok, asic_miner} ->
        notify_parent({:saved, asic_miner})

        {:noreply,
         socket
         |> put_flash(:info, "Asic miner created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
