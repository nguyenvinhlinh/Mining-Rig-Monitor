defmodule MiningRigMonitorWeb.MiningRigLive.PreDeleteFormComponent do
  use MiningRigMonitorWeb, :live_component

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <h5 id="drawer-label" class="inline-flex items-center text-sm font-semibold text-gray-500 uppercase dark:text-gray-400">Delete mining rig</h5>
      <svg class="w-10 h-10 mt-8 mb-4 text-red-600" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4m0 4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"></path></svg>
      <h3 class="mb-6 text-lg text-gray-500 dark:text-gray-400">
        Are you sure you want to delete this mining rig: <br/>
        <b><%= @mining_rig.name %> </b>
      </h3>



      <.link
        phx-click={JS.push("delete", value: %{id: @mining_rig.id}) |> JS.patch(~p"/mining_rigs")}
      >
        <button type="button" class="inline-flex items-center px-3 py-2 text-sm font-medium text-center text-white bg-red-600 rounded-lg hover:bg-red-800 focus:ring-4 focus:ring-red-300 dark:focus:ring-red-900">
          Yes, I'm sure
        </button>
      </.link>



      <.link
        phx-click={JS.patch(~p"/mining_rigs")}
      >
        <button type="button" class="text-gray-900 bg-white hover:bg-gray-100 focus:ring-4 focus:ring-primary-300 border border-gray-200
          font-medium inline-flex items-center rounded-lg text-sm px-3 py-2.5 text-center dark:bg-gray-800 dark:text-gray-400
          dark:border-gray-600 dark:hover:text-white dark:hover:bg-gray-700 dark:focus:ring-gray-700">
          No, cancel
        </button>
      </.link>
    </div>
    """
  end
end
