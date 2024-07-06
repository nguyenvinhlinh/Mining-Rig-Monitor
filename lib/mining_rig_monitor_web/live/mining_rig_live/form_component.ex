defmodule MiningRigMonitorWeb.MiningRigLive.FormComponent do
  use MiningRigMonitorWeb, :live_component

  alias MiningRigMonitor.MiningRigs

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage mining rig records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="mining_rig-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:name]} type="text" label="Name" />
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
    code = UUID.uuid1()
    mod_mining_rig_params = Map.put(mining_rig_params, "code", code)

    case MiningRigs.create_mining_rig(mod_mining_rig_params) do
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
