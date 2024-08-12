defmodule MiningRigMonitorWeb.MiningRigLive.Index do
  use MiningRigMonitorWeb, :live_view

  alias MiningRigMonitor.MiningRigs
  alias MiningRigMonitor.MiningRigs.MiningRig

  @impl true
  def mount(_params, _session, socket) do
    query_new_mining_rig_list = MiningRigs.query_filter_by_type(MiningRig, MiningRig.type_nil())
    new_mining_rig_list = MiningRigs.list_mining_rigs_by_query(query_new_mining_rig_list)
    new_mining_rig_list_length = Kernel.length(new_mining_rig_list)
    show_new_mining_rig_list? = if new_mining_rig_list_length > 0, do: true, else: false

    query_cpu_gpu_mining_rig_list = MiningRigs.query_filter_by_type(MiningRig, MiningRig.type_cpu_gpu())
    cpu_gpu_mining_rig_list = MiningRigs.list_mining_rigs_by_query(query_cpu_gpu_mining_rig_list)
    cpu_gpu_mining_rig_list_length = Kernel.length(cpu_gpu_mining_rig_list)
    show_cpu_gpu_mining_rig_list? = if cpu_gpu_mining_rig_list_length > 0, do: true, else: false

    query_cpu_gpu_mining_rig_list = MiningRigs.query_filter_by_type(MiningRig, MiningRig.type_asic())
    asic_mining_rig_list = MiningRigs.list_mining_rigs_by_query(query_cpu_gpu_mining_rig_list)
    asic_mining_rig_list_length = Kernel.length(asic_mining_rig_list)
    show_asic_mining_rig_list? = if asic_mining_rig_list_length > 0, do: true, else: false

    new_socket = socket
    |> stream(:new_mining_rig_list, new_mining_rig_list)
    |> stream(:cpu_gpu_mining_rig_list, cpu_gpu_mining_rig_list)
    |> assign(:show_new_mining_rig_list?, show_new_mining_rig_list?)
    |> stream(:asic_mining_rig_list,asic_mining_rig_list)
    |> assign(:show_cpu_gpu_mining_rig_list?, show_cpu_gpu_mining_rig_list?)
    |> assign(:show_asic_mining_rig_list?, show_asic_mining_rig_list?)
    |> assign(:new_mining_rig_list_length, new_mining_rig_list_length)
    |> assign(:cpu_gpu_mining_rig_list_length, cpu_gpu_mining_rig_list_length)
    |> assign(:asic_mining_rig_list_length, asic_mining_rig_list_length)
    {:ok, new_socket}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit mining rig")
    |> assign(:mining_rig, MiningRigs.get_mining_rig!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "Create new mining rig")
    |> assign(:mining_rig, %MiningRig{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Mining rigs")
    |> assign(:mining_rig, nil)
  end

  defp apply_action(socket, :pre_delete, %{"id" => id}) do
    socket
    |> assign(:page_title, "Delete mining rig")
    |> assign(:mining_rig, MiningRigs.get_mining_rig!(id))
  end

  @impl true
  def handle_info({MiningRigMonitorWeb.MiningRigLive.FormComponent, {:saved, mining_rig}}, socket) do
    case mining_rig.type do
      nil ->
        new_mining_rig_list_length = socket.assigns.new_mining_rig_list_length + 1
        new_socket = socket
        |> stream_insert(:new_mining_rig_list, mining_rig)
        |> assign(:new_mining_rig_list_length, new_mining_rig_list_length)
        |> assign(:show_new_mining_rig_list?, true)

        {:noreply, new_socket}
      "cpu_gpu" ->
        cpu_gpu_mining_rig_list_length = socket.assigns.cpu_gpu_mining_rig_list_length + 1
        new_socket = socket
        |> stream_insert(socket, :cpu_gpu_mining_rig_list, mining_rig)
        |> assign(:cpu_gpu_mining_rig_list_length, cpu_gpu_mining_rig_list_length)
        |> assign(:show_cpu_gpu_mining_rig_list?, true)
        {:noreply, new_socket}
      "asic" ->
        asic_mining_rig_list_length = socket.assigns.asic_mining_rig_list_length + 1
        new_socket = socket
        |> stream_insert(:asic_mining_rig_list, mining_rig)
        |> assign(:show_asic_mining_rig_list?, true)
        |> assign(:asic_mining_rig_list_length, asic_mining_rig_list_length)
        {:noreply, new_socket}
    end
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    mining_rig = MiningRigs.get_mining_rig!(id)
    {:ok, _} = MiningRigs.delete_mining_rig(mining_rig)

    case mining_rig.type do
      nil ->
        new_mining_rig_list_length = socket.assigns.new_mining_rig_list_length - 1
        show_new_mining_rig_list? = if new_mining_rig_list_length > 0, do: true, else: false
        new_socket = socket
        |> stream_delete(:new_mining_rig_list, mining_rig)
        |> assign(:new_mining_rig_list_length, new_mining_rig_list_length)
        |> assign(:show_new_mining_rig_list?, show_new_mining_rig_list?)
        {:noreply, new_socket}
      "cpu_gpu" ->
        cpu_gpu_mining_rig_list_length = socket.assigns.cpu_gpu_mining_rig_list_length - 1
        show_cpu_gpu_mining_rig_list? = if cpu_gpu_mining_rig_list_length > 0, do: true, else: false
        new_socket = socket
        |> stream_delete(:cpu_gpu_mining_rig_list, mining_rig)
        |> assign(:cpu_gpu_mining_rig_list_length, cpu_gpu_mining_rig_list_length)
        |> assign(:show_cpu_gpu_mining_rig_list?, show_cpu_gpu_mining_rig_list?)
        {:noreply, new_socket}
      "asic" ->
        asic_mining_rig_list_length = socket.assigns.asic_mining_rig_list_length - 1
        show_asic_mining_rig_list? = if asic_mining_rig_list_length > 0, do: true, else: false
        new_socket = socket
        |> stream_delete(:asic_mining_rig_list, mining_rig)
        |> assign(:asic_mining_rig_list_length, asic_mining_rig_list_length)
        |> assign(:show_asic_mining_rig_list?, show_asic_mining_rig_list?)
        {:noreply, new_socket}
    end
  end
end
