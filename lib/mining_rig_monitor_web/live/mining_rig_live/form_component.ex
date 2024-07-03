defmodule MiningRigMonitorWeb.MiningRigLive.FormComponent do
  use MiningRigMonitorWeb, :live_component

  alias MiningRigMonitor.MiningRigs

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage mining_rig records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="mining_rig-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:name]} type="text" label="Name" />
        <.input field={@form[:code]} type="text" label="Code" />
        <.input field={@form[:cpu_1_name]} type="text" label="Cpu 1 name" />
        <.input field={@form[:cpu_2_name]} type="text" label="Cpu 2 name" />
        <.input field={@form[:ram_1_size]} type="text" label="Ram 1 size" />
        <.input field={@form[:ram_2_size]} type="text" label="Ram 2 size" />
        <.input field={@form[:ram_3_size]} type="text" label="Ram 3 size" />
        <.input field={@form[:ram_4_size]} type="text" label="Ram 4 size" />
        <.input field={@form[:ram_1_type]} type="text" label="Ram 1 type" />
        <.input field={@form[:ram_2_type]} type="text" label="Ram 2 type" />
        <.input field={@form[:ram_3_type]} type="text" label="Ram 3 type" />
        <.input field={@form[:ram_4_type]} type="text" label="Ram 4 type" />
        <.input field={@form[:ram_1_manufacture]} type="text" label="Ram 1 manufacture" />
        <.input field={@form[:ram_2_manufacture]} type="text" label="Ram 2 manufacture" />
        <.input field={@form[:ram_3_manufacture]} type="text" label="Ram 3 manufacture" />
        <.input field={@form[:ram_4_manufacture]} type="text" label="Ram 4 manufacture" />
        <.input field={@form[:ram_1_part_number]} type="text" label="Ram 1 part number" />
        <.input field={@form[:ram_2_part_number]} type="text" label="Ram 2 part number" />
        <.input field={@form[:ram_3_part_number]} type="text" label="Ram 3 part number" />
        <.input field={@form[:ram_4_part_number]} type="text" label="Ram 4 part number" />
        <.input field={@form[:vga_1_name]} type="text" label="Vga 1 name" />
        <.input field={@form[:vga_2_name]} type="text" label="Vga 2 name" />
        <.input field={@form[:vga_3_name]} type="text" label="Vga 3 name" />
        <.input field={@form[:vga_4_name]} type="text" label="Vga 4 name" />
        <.input field={@form[:vga_1_driver_version]} type="text" label="Vga 1 driver version" />
        <.input field={@form[:vga_2_driver_version]} type="text" label="Vga 2 driver version" />
        <.input field={@form[:vga_3_driver_version]} type="text" label="Vga 3 driver version" />
        <.input field={@form[:vga_4_driver_version]} type="text" label="Vga 4 driver version" />
        <.input field={@form[:vga_1_vbios_version]} type="text" label="Vga 1 vbios version" />
        <.input field={@form[:vga_2_vbios_version]} type="text" label="Vga 2 vbios version" />
        <.input field={@form[:vga_3_vbios_version]} type="text" label="Vga 3 vbios version" />
        <.input field={@form[:vga_4_vbios_version]} type="text" label="Vga 4 vbios version" />
        <.input field={@form[:vga_1_total_memory]} type="text" label="Vga 1 total memory" />
        <.input field={@form[:vga_2_total_memory]} type="text" label="Vga 2 total memory" />
        <.input field={@form[:vga_3_total_memory]} type="text" label="Vga 3 total memory" />
        <.input field={@form[:vga_4_total_memory]} type="text" label="Vga 4 total memory" />
        <.input field={@form[:vga_1_pci_bus_id]} type="text" label="Vga 1 pci bus" />
        <.input field={@form[:vga_2_pci_bus_id]} type="text" label="Vga 2 pci bus" />
        <.input field={@form[:vga_3_pci_bus_id]} type="text" label="Vga 3 pci bus" />
        <.input field={@form[:vga_4_pci_bus_id]} type="text" label="Vga 4 pci bus" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Mining rig</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{mining_rig: mining_rig} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(MiningRigs.change_mining_rig(mining_rig))
     end)}
  end

  @impl true
  def handle_event("validate", %{"mining_rig" => mining_rig_params}, socket) do
    changeset = MiningRigs.change_mining_rig(socket.assigns.mining_rig, mining_rig_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"mining_rig" => mining_rig_params}, socket) do
    save_mining_rig(socket, socket.assigns.action, mining_rig_params)
  end

  defp save_mining_rig(socket, :edit, mining_rig_params) do
    case MiningRigs.update_mining_rig(socket.assigns.mining_rig, mining_rig_params) do
      {:ok, mining_rig} ->
        notify_parent({:saved, mining_rig})

        {:noreply,
         socket
         |> put_flash(:info, "Mining rig updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_mining_rig(socket, :new, mining_rig_params) do
    case MiningRigs.create_mining_rig(mining_rig_params) do
      {:ok, mining_rig} ->
        notify_parent({:saved, mining_rig})

        {:noreply,
         socket
         |> put_flash(:info, "Mining rig created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
