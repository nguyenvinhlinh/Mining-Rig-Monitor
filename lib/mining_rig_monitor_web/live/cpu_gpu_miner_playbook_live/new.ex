defmodule MiningRigMonitorWeb.CpuGpuMinerPlaybookLive.New do
  use MiningRigMonitorWeb, :live_view_container_grow
  alias MiningRigMonitor.CpuGpuMiners
  alias MiningRigMonitor.CpuGpuMinerPlaybooks.CpuGpuMinerPlaybook
  alias MiningRigMonitor.CpuGpuMinerPlaybooks

  on_mount MiningRigMonitorWeb.UserAuthLive
  embed_templates "new_html/*"

  @impl true
  def mount(%{"cpu_gpu_miner_id" => cpu_gpu_miner_id}, _session, socket) do
    cpu_gpu_miner = CpuGpuMiners.get_cpu_gpu_miner!(cpu_gpu_miner_id)
    software_name_option_list = CpuGpuMinerPlaybook.get_software_name_list()
    software_version_option_list = CpuGpuMinerPlaybook.get_software_version_list_by_name("XMRig")
    wallet_address_option_list = MiningRigMonitor.Addresses.list_addresses_by_type("wallet")
    |> Enum.map(fn(e) ->
      {e.name, e.id}
    end)
    wallet_address_option_list_mod = [{"----", ""}] ++ wallet_address_option_list
    pool_address_option_list = MiningRigMonitor.Addresses.list_addresses_by_type("pool")
    |> Enum.map(fn(e) ->
      {e.name, e.id}
    end)
    pool_address_option_list_mod = [{"----", ""}] ++ pool_address_option_list


    form = %CpuGpuMinerPlaybook{}
    |> CpuGpuMinerPlaybooks.change_new_cpu_gpu_miner_playbook()
    |> to_form()
    socket_mod = socket
    |> assign(:cpu_gpu_miner, cpu_gpu_miner)
    |> assign(:software_name_option_list, software_name_option_list)
    |> assign(:software_version_option_list, software_version_option_list)
    |> assign(:wallet_address_option_list, wallet_address_option_list_mod)
    |> assign(:pool_address_option_list, pool_address_option_list_mod)
    |> assign(:form, form)
    {:ok, socket_mod}
  end

  @impl true
  def handle_event("validate", %{"cpu_gpu_miner_playbook" => playbook_params}, socket) do
    params_software_name = Map.get(playbook_params, "software_name")
    software_version_option_list = CpuGpuMinerPlaybook.get_software_version_list_by_name(params_software_name)
    changeset = CpuGpuMinerPlaybooks.change_new_cpu_gpu_miner_playbook(%CpuGpuMinerPlaybook{}, playbook_params)
    form = to_form(changeset, action: :validate)
    socket_mod = socket
    |> assign(:form, form)
    |> assign(:software_version_option_list, software_version_option_list)
    {:noreply, socket_mod}
  end

  @impl true
  def handle_event("save", %{"cpu_gpu_miner_playbook" => playbook_params}, socket) do
    cpu_gpu_miner = socket.assigns[:cpu_gpu_miner]
    playbook_params_mod = Map.put(playbook_params, "cpu_gpu_miner_id", cpu_gpu_miner.id)

    case CpuGpuMinerPlaybooks.create_cpu_gpu_miner_playbook(playbook_params_mod) do
      {:ok, miner_playbook} ->
        socket_mod = socket
        |> put_flash(:info, "Playbook #{miner_playbook.software_name} #{miner_playbook.software_version} created successfully")
        |> push_navigate(to: ~p"/cpu_gpu_miners/#{cpu_gpu_miner.id}/playbooks/#{miner_playbook.id}")
        {:noreply, socket_mod}
      {:error, %Ecto.Changeset{} = changeset} ->
        form = to_form(changeset)
        socket_mod = socket
        |> assign(:form, form)
        |> put_flash(:error, "Please fix playbook error before saving...")
        {:noreply, socket_mod}
    end
  end
end
