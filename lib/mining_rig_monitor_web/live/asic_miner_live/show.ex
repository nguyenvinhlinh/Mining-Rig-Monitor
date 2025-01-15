defmodule MiningRigMonitorWeb.AsicMinerLive.Show do
  use MiningRigMonitorWeb, :live_view

  alias MiningRigMonitor.AsicMiners
  alias MiningRigMonitor.AsicMinerLogs.AsicMinerLog
  alias MiningRigMonitor.GenServer.AsicMinerOperationalIndex
  alias MiningRigMonitor.Utility

  embed_templates "show_html/*"
  @impl true
  def mount(%{"id" => asic_miner_id}, _session, socket) do
    asic_miner = AsicMiners.get_asic_miner!(asic_miner_id)
    asic_miner_log = AsicMinerOperationalIndex.get(asic_miner.id)

    asic_miner_log_mod =
    if Kernel.is_nil(asic_miner_log)  do
      empty_asic_miner_log()
    else
      beautify_asic_miner_log(asic_miner_log)
    end

    if connected?(socket) do
      asic_miner_channel = "asic_miner_channel:#{asic_miner.id}"
      asic_miner_operational_channel = "asic_miner_operational_channel:#{asic_miner.id}"
      Phoenix.PubSub.subscribe(MiningRigMonitor.PubSub, asic_miner_channel)
      Phoenix.PubSub.subscribe(MiningRigMonitor.PubSub, asic_miner_operational_channel)
    end

    new_socket = socket
    |> assign(:asic_miner, asic_miner)
    |> assign(:asic_miner_log, asic_miner_log_mod)

    {:ok, new_socket}
  end

  @impl true
  def handle_info({:asic_miner_operational_channel , :create_asic_miner_log, asic_miner_log}, socket) do
    asic_miner_log_mod = beautify_asic_miner_log(asic_miner_log)

    new_socket = socket
    |> assign(:asic_miner_log, asic_miner_log_mod)
    {:noreply, new_socket}
  end

  @impl true
  def handle_info({:asic_miner_channel , :update_asic_miner, asic_miner}, socket) do
    new_socket = socket
    |> assign(:asic_miner, asic_miner)
    {:noreply, new_socket}
  end

  def beautify_asic_miner_log(%AsicMinerLog{} = asic_miner_log) do
    uptime_mod = Utility.beautify_uptime(asic_miner_log.uptime)
    hashrate_uom_mod = Utility.unify_hashrate_uom(asic_miner_log.hashrate_uom)
    coin_name_mod = asic_miner_log.coin_name |> String.downcase() |> String.capitalize()

    asic_miner_log
    |> Map.put(:uptime, uptime_mod)
    |> Map.put(:hashrate_uom, hashrate_uom_mod)
    |> Map.put(:coin_name, coin_name_mod)
  end


  def empty_asic_miner_log() do
    %MiningRigMonitor.AsicMinerLogs.AsicMinerLog{}
    |> Map.put(:power, 0)
    |> Map.put(:hashboard_1_hashrate_5_min,  0)
    |> Map.put(:hashboard_1_hashrate_30_min, 0)
    |> Map.put(:hashboard_2_hashrate_5_min,  0)
    |> Map.put(:hashboard_2_hashrate_30_min, 0)
    |> Map.put(:hashboard_3_hashrate_5_min,  0)
    |> Map.put(:hashboard_3_hashrate_30_min, 0)
    |> Map.put(:hashboard_1_temp_1, 0)
    |> Map.put(:hashboard_1_temp_2, 0)
    |> Map.put(:hashboard_2_temp_1, 0)
    |> Map.put(:hashboard_2_temp_2, 0)
    |> Map.put(:hashboard_3_temp_1, 0)
    |> Map.put(:hashboard_3_temp_2, 0)
    |> Map.put(:hashrate_5_min,  0)
    |> Map.put(:hashrate_30_min, 0)
    |> Map.put(:uptime, "OFFLINE")
    |> Map.put(:fan_1_speed, 0)
    |> Map.put(:fan_2_speed, 0)
    |> Map.put(:fan_3_speed, 0)
    |> Map.put(:fan_4_speed, 0)
    |> Map.put(:pool_1_address, "----")
    |> Map.put(:pool_2_address, "----")
    |> Map.put(:pool_3_address, "----")
    |> Map.put(:pool_1_user, "----")
    |> Map.put(:pool_2_user, "----")
    |> Map.put(:pool_3_user, "----")
    |> Map.put(:pool_1_state, "----")
    |> Map.put(:pool_2_state, "----")
    |> Map.put(:pool_3_state, "----")
    |> Map.put(:pool_1_accepted_share, "----")
    |> Map.put(:pool_2_accepted_share, "----")
    |> Map.put(:pool_3_accepted_share, "----")
    |> Map.put(:pool_1_rejected_share, "----")
    |> Map.put(:pool_2_rejected_share, "----")
    |> Map.put(:pool_3_rejected_share, "----")
    |> Map.put(:lan_ip, "----")
    |> Map.put(:wan_ip, "----")
    |> Map.put(:coin_name, "----")
  end
end
