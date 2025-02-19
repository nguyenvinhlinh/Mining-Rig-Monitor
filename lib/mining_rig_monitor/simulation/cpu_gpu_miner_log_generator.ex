defmodule MiningRigMonitor.Simulation.CpuGpuMinerLogGenerator do
  use GenServer

  require Logger

  @post_url "http://127.0.0.1:4000/api/v1/cpu_gpu_miners/logs"
  @api_code_list ["api_code_1", "api_code_2"]
  @post_inverval_second 1


  def start_link() do
    GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  end

  def start_link(_params) do
    GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  end

  @impl true
  def init(_) do
    Logger.info("[CpuGpuMinerLogGenerator] Start")
    Process.send_after(self(), :submit_cpu_gpu_miner_log, @post_inverval_second * 1000)
    {:ok, nil}
  end

  @impl true
  def handle_info(:submit_cpu_gpu_miner_log, state) do
    Logger.info("[CpuGpuMinerLogGenerator] Submit cpu/gpu miner logs")
    for api_code <- @api_code_list do
      cpu_gpu_miner_log = generate_cpu_gpu_miner_log()
      submit(api_code, cpu_gpu_miner_log)
    end
    Process.send_after(self(), :submit_cpu_gpu_miner_log, @post_inverval_second * 1000)
    {:noreply, state}
  end


  def generate_cpu_gpu_miner_log() do
    %{
      "cpu_temp" => 60,
      "cpu_hashrate" => 17,
      "cpu_hashrate_uom" => "kh/s",
      "cpu_algorithm" => "RandomX",
      "cpu_coin_name" => "Monero",
      "cpu_pool_address" => "xxx pool " ,
      "cpu_wallet" => "xxx wallet",
      "cpu_power" => 200,
      "gpu_1_core_temp" => 60 * (1 + Enum.random(1..10) / 100) |> Kernel.round(),
      "gpu_2_core_temp" => 60 * (1 + Enum.random(1..10) / 100) |> Kernel.round(),
      "gpu_3_core_temp" => 60 * (1 + Enum.random(1..10) / 100) |> Kernel.round(),
      "gpu_4_core_temp" => 60 * (1 + Enum.random(1..10) / 100) |> Kernel.round(),
      "gpu_5_core_temp" => 60 * (1 + Enum.random(1..10) / 100) |> Kernel.round(),
      "gpu_6_core_temp" => 60 * (1 + Enum.random(1..10) / 100) |> Kernel.round(),
      "gpu_7_core_temp" => 60 * (1 + Enum.random(1..10) / 100) |> Kernel.round(),
      "gpu_8_core_temp" => 60 * (1 + Enum.random(1..10) / 100) |> Kernel.round(),
      "gpu_1_mem_temp" => 60 * (1 + Enum.random(1..10) / 100) |> Kernel.round(),
      "gpu_2_mem_temp" => 60 * (1 + Enum.random(1..10) / 100) |> Kernel.round(),
      "gpu_3_mem_temp" => 60 * (1 + Enum.random(1..10) / 100) |> Kernel.round(),
      "gpu_4_mem_temp" => 60 * (1 + Enum.random(1..10) / 100) |> Kernel.round(),
      "gpu_5_mem_temp" => 60 * (1 + Enum.random(1..10) / 100) |> Kernel.round(),
      "gpu_6_mem_temp" => 60 * (1 + Enum.random(1..10) / 100) |> Kernel.round(),
      "gpu_7_mem_temp" => 60 * (1 + Enum.random(1..10) / 100) |> Kernel.round(),
      "gpu_8_mem_temp" => 60 * (1 + Enum.random(1..10) / 100) |> Kernel.round(),
      "gpu_1_hashrate_1" => 1000 * (1 + Enum.random(1..10) / 100) |> Kernel.round(),
      "gpu_2_hashrate_1" => 1000 * (1 + Enum.random(1..10) / 100) |> Kernel.round(),
      "gpu_3_hashrate_1" => 1000 * (1 + Enum.random(1..10) / 100) |> Kernel.round(),
      "gpu_4_hashrate_1" => 1000 * (1 + Enum.random(1..10) / 100) |> Kernel.round(),
      "gpu_5_hashrate_1" => 1000 * (1 + Enum.random(1..10) / 100) |> Kernel.round(),
      "gpu_6_hashrate_1" => 1000 * (1 + Enum.random(1..10) / 100) |> Kernel.round(),
      "gpu_7_hashrate_1" => 1000 * (1 + Enum.random(1..10) / 100) |> Kernel.round(),
      "gpu_8_hashrate_1" => 1000 * (1 + Enum.random(1..10) / 100) |> Kernel.round(),
      "gpu_1_hashrate_2" => 1000 * (1 + Enum.random(1..10) / 100) |> Kernel.round(),
      "gpu_2_hashrate_2" => 1000 * (1 + Enum.random(1..10) / 100) |> Kernel.round(),
      "gpu_3_hashrate_2" => 1000 * (1 + Enum.random(1..10) / 100) |> Kernel.round(),
      "gpu_4_hashrate_2" => 1000 * (1 + Enum.random(1..10) / 100) |> Kernel.round(),
      "gpu_5_hashrate_2" => 1000 * (1 + Enum.random(1..10) / 100) |> Kernel.round(),
      "gpu_6_hashrate_2" => 1000 * (1 + Enum.random(1..10) / 100) |> Kernel.round(),
      "gpu_7_hashrate_2" => 1000 * (1 + Enum.random(1..10) / 100) |> Kernel.round(),
      "gpu_8_hashrate_2" => 1000 * (1 + Enum.random(1..10) / 100) |> Kernel.round(),
      "gpu_1_core_clock" => 100  * (1 + Enum.random(1..10) / 100) |> Kernel.round(),
      "gpu_2_core_clock" => 1000 * (1 + Enum.random(1..10) / 100) |> Kernel.round(),
      "gpu_3_core_clock" => 1000 * (1 + Enum.random(1..10) / 100) |> Kernel.round(),
      "gpu_4_core_clock" => 1000 * (1 + Enum.random(1..10) / 100) |> Kernel.round(),
      "gpu_5_core_clock" => 1000 * (1 + Enum.random(1..10) / 100) |> Kernel.round(),
      "gpu_6_core_clock" => 1000 * (1 + Enum.random(1..10) / 100) |> Kernel.round(),
      "gpu_7_core_clock" => 1000 * (1 + Enum.random(1..10) / 100) |> Kernel.round(),
      "gpu_8_core_clock" => 1000 * (1 + Enum.random(1..10) / 100) |> Kernel.round(),
      "gpu_1_mem_clock" => 1000 * (1 + Enum.random(1..10) / 100) |> Kernel.round(),
      "gpu_2_mem_clock" => 1000 * (1 + Enum.random(1..10) / 100) |> Kernel.round(),
      "gpu_3_mem_clock" => 1000 * (1 + Enum.random(1..10) / 100) |> Kernel.round(),
      "gpu_4_mem_clock" => 1000 * (1 + Enum.random(1..10) / 100) |> Kernel.round(),
      "gpu_5_mem_clock" => 1000 * (1 + Enum.random(1..10) / 100) |> Kernel.round(),
      "gpu_6_mem_clock" => 1000 * (1 + Enum.random(1..10) / 100) |> Kernel.round(),
      "gpu_7_mem_clock" => 1000 * (1 + Enum.random(1..10) / 100) |> Kernel.round(),
      "gpu_8_mem_clock" => 1000 * (1 + Enum.random(1..10) / 100) |> Kernel.round(),
      "gpu_1_power" => 1000 * (1 + Enum.random(1..10) / 100) |> Kernel.round(),
      "gpu_2_power" => 1000 * (1 + Enum.random(1..10) / 100) |> Kernel.round(),
      "gpu_3_power" => 1000 * (1 + Enum.random(1..10) / 100) |> Kernel.round(),
      "gpu_4_power" => 1000 * (1 + Enum.random(1..10) / 100) |> Kernel.round(),
      "gpu_5_power" => 1000 * (1 + Enum.random(1..10) / 100) |> Kernel.round(),
      "gpu_6_power" => 1000 * (1 + Enum.random(1..10) / 100) |> Kernel.round(),
      "gpu_7_power" => 1000 * (1 + Enum.random(1..10) / 100) |> Kernel.round(),
      "gpu_8_power" => 1000 * (1 + Enum.random(1..10) / 100) |> Kernel.round(),
      "gpu_hashrate_uom_1" => "MH/s",
      "gpu_hashrate_uom_2" => "SOL/s",
      "gpu_algorithm_1" => "Ethash",
      "gpu_algorithm_2" => "Autokylos",
      "gpu_coin_name_1" => "Ethereum",
      "gpu_coin_name_2" => "Ergo",
      "lan_ip" => "192.168.15.6",
      "wan_ip" => "54.66.85.99"
    }
  end

  def submit(api_code, cpu_gpu_miner_log_data) do
    header_list = [
      {"Content-Type", "application/json"},
      {"API_CODE", api_code}
    ]

    cpu_gpu_miner_log_json = Jason.encode!(cpu_gpu_miner_log_data)
    HTTPoison.post(@post_url, cpu_gpu_miner_log_json, header_list)
  end

  def test() do
    api_code = "21b324e4-e9fb-11ef-88f2-ac1f6be80ad4"
    cpu_gpu_miner_log_data = generate_cpu_gpu_miner_log()
    submit(api_code, cpu_gpu_miner_log_data)
  end

end
