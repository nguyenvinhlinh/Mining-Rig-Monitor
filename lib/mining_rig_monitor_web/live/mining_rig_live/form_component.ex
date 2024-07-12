defmodule MiningRigMonitorWeb.MiningRigLive.FormComponent do
  use MiningRigMonitorWeb, :live_component

  alias MiningRigMonitor.MiningRigs

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
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
          <button phx-disable-with="Saving..."
            type="submit"
            class="phx-submit-loading:opacity-75 rounded-lg bg-zinc-900  py-2 px-3 text-sm font-semibold leading-6 text-white active:text-white/80
              text-white w-full justify-center bg-blue-700 hover:bg-blue-800 focus:ring-4
              focus:outline-none focus:ring-blue-300 font-medium rounded-lg text-sm px-5 py-2.5 text-center
              dark:bg-blue-600 dark:hover:bg-blue-700 dark:focus:ring-blue-800"
          >
            Save
          </button>


          <button phx-click={JS.patch(~p"/mining_rigs")} type="button"
            class="rounded-lg bg-zinc-900 py-2 px-3 text-sm font-semibold leading-6 inline-flex w-full justify-center text-gray-500 items-center
              bg-white hover:bg-gray-100 focus:ring-4 focus:outline-none focus:ring-primary-300 rounded-lg border border-gray-200 text-sm font-medium
              px-5 py-2.5 hover:text-gray-900 focus:z-10 dark:bg-gray-700 dark:text-gray-300 dark:border-gray-500 dark:hover:text-white
              dark:hover:bg-gray-600 dark:focus:ring-gray-600"
          >
            Cancel
          </button>
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
