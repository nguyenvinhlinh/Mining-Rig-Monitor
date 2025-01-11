defmodule MiningRigMonitor.Simulation.AsicMinerLogGenerator do
  use GenServer

  require Logger

  @asic_miner_api_code_list ["asic_1_code", "asic_2_code", "asic_3_code"]
  @post_url "http://127.0.0.1:4000/api/v1/asic_miners/logs"
  @post_inverval_second 1

  # Client

  def start_link() do
    GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  end
  def start_link(_params) do
    GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  end

  # Server (callbacks)
  @impl true
  def init(_stack) do
    Logger.info("[AsicRigMonitorRecordGenerator] Start")
    Process.send_after(self(), :submit_asic_rig_monitor_record, @post_inverval_second * 1000)
    {:ok, nil}
  end

  @impl true
  def handle_info(:submit_asic_rig_monitor_record, state) do
    Logger.info("[AsicRigMonitorRecordGenerator] Submit asic rig monitor records")
    for mining_rig_code <- @asic_miner_api_code_list do
      asic_rig_monitor_data = generate_asic_rig_monitor_data()
      submit(mining_rig_code, asic_rig_monitor_data)
    end
    Process.send_after(self(), :submit_asic_rig_monitor_record, @post_inverval_second * 1000)
    {:noreply, state}
  end

  def generate_asic_rig_monitor_data() do
    hashrate_5_min = 10000 * (1 + Enum.random(1..10) / 100)
    hashrate_30_min = 10000 * (1 + Enum.random(1..10) / 100)
    hashboard_1_hashrate_5_min = 1000 * (1 + Enum.random(1..10) / 100)
    hashboard_2_hashrate_5_min = 1000 * (1 + Enum.random(1..10) / 100)
    hashboard_3_hashrate_5_min = 1000 * (1 + Enum.random(1..10) / 100)
    hashboard_1_hashrate_30_min = 1000 * (1 + Enum.random(1..10) / 100)
    hashboard_2_hashrate_30_min = 1000 * (1 + Enum.random(1..10) / 100)
    hashboard_3_hashrate_30_min = 1000 * (1 + Enum.random(1..10) / 100)
    hashboard_1_temp_1 = 60 * (1 + Enum.random(1..10) / 100) |> Kernel.round()
    hashboard_1_temp_2 = hashboard_1_temp_1 + 3 |> Kernel.round()
    hashboard_2_temp_1 = 60 * (1 + Enum.random(1..10) / 100) |> Kernel.round()
    hashboard_2_temp_2 = hashboard_2_temp_1 + 3 |> Kernel.round()
    hashboard_3_temp_1 = 60 * (1 + Enum.random(1..10) / 100) |> Kernel.round()
    hashboard_3_temp_2 = hashboard_3_temp_1 + 3 |> Kernel.round()
    fan_1_speed = 5500 * (1 + Enum.random(1..10) / 100) |> Kernel.round()
    fan_2_speed = 5500 * (1 + Enum.random(1..10) / 100) |> Kernel.round()
    fan_3_speed = 5500 * (1 + Enum.random(1..10) / 100) |> Kernel.round()
    fan_4_speed = 5500 * (1 + Enum.random(1..10) / 100) |> Kernel.round()

    %{
      "hashrate_5_min" => hashrate_5_min,
      "hashrate_30_min" => hashrate_30_min,
      "hashrate_uom" => "GH/s",
      "pool_rejection_rate" => 0.0001,
      "uptime" => "07:23:50:20",
      "pool_1_address" => "stratum+tcp://#{UUID.uuid1()}:4441",
      "pool_2_address" => "stratum+tcp://#{UUID.uuid1()}:4441",
      "pool_3_address" => "stratum+tcp://#{UUID.uuid1()}:4441",
      "pool_1_user" => "kaspa:#{UUID.uuid1()}.worker_1",
      "pool_2_user" => "kaspa:#{UUID.uuid1()}.worker_1",
      "pool_3_user" => "kaspa:#{UUID.uuid1()}.worker_1",
      "pool_1_state" => "Connected",
      "pool_2_state" => "Unconnected",
      "pool_3_state" => "Unconnected",
      "pool_1_accepted_share" => 100000,
      "pool_2_accepted_share" => 0,
      "pool_3_accepted_share" => 0,
      "pool_1_rejected_share" => 0,
      "pool_2_rejected_share" => 0,
      "pool_3_rejected_share" => 0,
      "hashboard_1_hashrate_5_min" => hashboard_1_hashrate_5_min,
      "hashboard_2_hashrate_5_min" => hashboard_2_hashrate_5_min,
      "hashboard_3_hashrate_5_min" => hashboard_3_hashrate_5_min,
      "hashboard_1_hashrate_30_min" => hashboard_1_hashrate_30_min,
      "hashboard_2_hashrate_30_min" => hashboard_2_hashrate_30_min,
      "hashboard_3_hashrate_30_min" => hashboard_3_hashrate_30_min,
      "hashboard_1_temp_1" => hashboard_1_temp_1,
      "hashboard_1_temp_2" => hashboard_1_temp_2,
      "hashboard_2_temp_1" => hashboard_2_temp_1,
      "hashboard_2_temp_2" => hashboard_2_temp_2,
      "hashboard_3_temp_1" => hashboard_3_temp_1,
      "hashboard_3_temp_2" => hashboard_3_temp_2,
      "fan_1_speed" => fan_1_speed,
      "fan_2_speed" => fan_2_speed,
      "fan_3_speed" => fan_3_speed,
      "fan_4_speed" => fan_4_speed,
      "lan_ip" => "192.168.18.50",
      "wan_ip" => "50.85.22.87",
      "coin_name" => "Kaspa",
      "power" => 3500
    }
  end

  def submit(api_code, asic_rig_monitor_data) do
    header_list = [
      {"Content-Type", "application/json"},
      {"API_CODE", api_code}
    ]

    asic_rig_monitor_data_json = Jason.encode!(asic_rig_monitor_data)
    HTTPoison.post(@post_url, asic_rig_monitor_data_json, header_list)
  end

  # This function is all about submit monitor record without kick-off the GenServer
  def test do
    mining_rig_code = "asic_1_code"
    asic_rig_monitor_data = generate_asic_rig_monitor_data()
    submit(mining_rig_code, asic_rig_monitor_data)
  end
end
