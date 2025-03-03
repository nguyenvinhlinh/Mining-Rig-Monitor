defmodule MiningRigMonitor.GenServer.CpuGpuMinerOperationalIndex do
  use GenServer

  alias MiningRigMonitor.CpuGpuMinerLogs.CpuGpuMinerLog
  alias MiningRigMonitor.CpuGpuMiners
  alias MiningRigMonitor.Utility

  require Logger
  #interface
  def start_link(_args), do: start_link()
  def start_link() do
    {:ok, pid} = GenServer.start_link(__MODULE__, nil, name: __MODULE__)
    Logger.info("[CpuGpuMinerOperationalIndex] started.")
    Logger.info("[CpuGpuMinerOperationalIndex][broadcast_operational_data] after 5 seconds")
    Logger.info("[CpuGpuMinerOperationalIndex][nillify_offline_miner] after 5 seconds")
    Process.send_after(__MODULE__, {:broadcast_operational_data}, 5_000)
    #Process.send_after(__MODULE__, {:nillify_offline_miner}, 5_000)
    {:ok, pid}
  end

  def get(cpu_gpu_miner_id) when Kernel.is_integer(cpu_gpu_miner_id) do
    GenServer.call(__MODULE__, {:get, cpu_gpu_miner_id})
  end

  def take(cpu_gpu_miner_id_list) when Kernel.is_list(cpu_gpu_miner_id_list) do
    GenServer.call(__MODULE__, {:take, cpu_gpu_miner_id_list})
  end

  def get_all() do
    GenServer.call(__MODULE__, {:get_all})
  end

  def put(%CpuGpuMinerLog{} = cpu_gpu_miner_log) do
    GenServer.cast(__MODULE__, {:put, cpu_gpu_miner_log})
  end

  #callback
  @impl true
  def init(_) do
    {:ok, %{}}
  end

  @impl true
  def handle_cast({:put, %CpuGpuMinerLog{} = cpu_gpu_miner_log}, state) do
    state_mod = state
    |> Map.put(cpu_gpu_miner_log.cpu_gpu_miner_id, cpu_gpu_miner_log)
    {:noreply, state_mod}
  end

  @impl true
  def handle_call({:get, cpu_gpu_miner_id}, _pid, state) when Kernel.is_integer(cpu_gpu_miner_id)do
    cpu_gpu_miner_log = Map.get(state, cpu_gpu_miner_id)
    {:reply, cpu_gpu_miner_log, state}
  end

  @impl true
  def handle_call({:take, cpu_gpu_miner_id_list}, _pid,  state) when Kernel.is_list(cpu_gpu_miner_id_list) do
    cpu_gpu_miner_log_map = Map.take(state, cpu_gpu_miner_id_list)
    {:reply, cpu_gpu_miner_log_map, state}
  end

  @impl true
  def handle_call({:get_all}, _pid, state), do: {:reply, state, state}

  @impl true
  def handle_info({:broadcast_operational_data}, state) do
    cpu_gpu_miner_map = CpuGpuMiners.list_cpu_gpu_miners_by_activated_state(true)
    |> Enum.reduce(%{}, fn(e, a) -> Map.put(a, e.id, e) end)

    cpu_gpu_miner_operational_map = state

    total_power = Enum.reduce(cpu_gpu_miner_operational_map, 0, fn({e_key, e_value}, acc) ->
      acc + CpuGpuMinerLog.sum_total_power(e_value)
    end)
    total_cpu_gpu_miner = Map.keys(cpu_gpu_miner_map) |> Kernel.length()
    total_running_asic_miner = Map.keys(cpu_gpu_miner_operational_map) |> Kernel.length()
    cpu_gpu_miner_alive = "#{total_running_asic_miner}/#{total_cpu_gpu_miner}"
    coin_hashrate_map = get_coin_hashrate_map(cpu_gpu_miner_operational_map)
    |> Enum.reduce(%{}, fn({coin_name, hashrate_tuple}, a) ->
      hashrate_tuple_mod = Utility.beautify_hashrate(hashrate_tuple)
      Map.put(a, coin_name, hashrate_tuple_mod)
    end)

    data = %{
      cpu_gpu_miner_map: cpu_gpu_miner_map,
      cpu_gpu_miner_operational_map: cpu_gpu_miner_operational_map,
      aggregated_index: %{
        total_power: total_power,
        cpu_gpu_miner_alive: cpu_gpu_miner_alive,
        coin_hashrate_map: coin_hashrate_map
      }
    }
    Phoenix.PubSub.broadcast(MiningRigMonitor.PubSub, "cpu_gpu_miner_index_operational_channel",
      {:cpu_gpu_miner_index_operational_channel , :operational_data, data})
    Process.send_after(__MODULE__, {:broadcast_operational_data}, 1_000)
    {:noreply, state}
  end

  def get_coin_hashrate_map(cpu_gpu_operational_map) do
    Enum.reduce(cpu_gpu_operational_map, %{}, fn({cpu_gpu_miner_id, cpu_gpu_miner_log}, acc) ->
      acc_mod_1 =
        case CpuGpuMinerLog.get_cpu_coin_hashrate_tuple(cpu_gpu_miner_log) do
          {cpu_coin_name, cpu_hashrate, cpu_hashrate_uom} ->
            if Map.keys(acc) |> Enum.member?(cpu_coin_name) do
              old_hashrate = Map.get(acc, cpu_coin_name)
              new_hashrate = {cpu_hashrate, cpu_hashrate_uom}
              sum_hashrate = HashrateArithmetic.add(old_hashrate, new_hashrate)
              Map.put(acc, cpu_coin_name, sum_hashrate)
            else
              Map.put(acc, cpu_coin_name, {cpu_hashrate, cpu_hashrate_uom})
            end
          nil -> acc
        end

      acc_mod_2 =
        case CpuGpuMinerLog.get_gpu_coin_1_hashrate_tuple(cpu_gpu_miner_log) do
          {gpu_coin_name_1, gpu_hashrate_1, gpu_hashrate_uom_1} ->
            if Map.keys(acc_mod_1) |> Enum.member?(gpu_coin_name_1) do
              old_hashrate = Map.get(acc, gpu_coin_name_1)
              new_hashrate = {gpu_hashrate_1, gpu_hashrate_uom_1}
              sum_hashrate = HashrateArithmetic.add(old_hashrate, new_hashrate)
              Map.put(acc_mod_1, gpu_coin_name_1, sum_hashrate)
            else
              Map.put(acc_mod_1, gpu_coin_name_1, {gpu_hashrate_1, gpu_hashrate_uom_1})
            end
          nil -> acc_mod_1
        end

      acc_mod_3 =
        case CpuGpuMinerLog.get_gpu_coin_2_hashrate_tuple(cpu_gpu_miner_log) do
          {gpu_coin_name_2, gpu_hashrate_2, gpu_hashrate_uom_2} ->
            if Map.keys(acc_mod_2) |> Enum.member?(gpu_coin_name_2) do
              old_hashrate = Map.get(acc, gpu_coin_name_2)
              new_hashrate = {gpu_hashrate_2, gpu_hashrate_uom_2}
              sum_hashrate = HashrateArithmetic.add(old_hashrate, new_hashrate)
              Map.put(acc_mod_2, gpu_coin_name_2, sum_hashrate)
            else
              Map.put(acc_mod_2, gpu_coin_name_2, {gpu_hashrate_2, gpu_hashrate_uom_2})
            end
          nil -> acc_mod_2
        end
      acc_mod_3
    end)
  end

  # TODO refactor to help writing unit test.
  # @impl true
  # def handle_info({:broadcast_operational_data}, state) do
  #   Logger.info("[AsicMinerOperationalIndex][broadcast_operational_data] Starting.")
  #   asic_miner_map = AsicMiners.list_asic_miners_by_activated_state(true)
  #   |> Enum.reduce(%{}, fn(e, acc) -> Map.put(acc, e.id, e) end)

  #   asic_miner_operational_map = state

  #   coin_hashrate_map =
  #     Enum.reduce(state, %{},
  #       fn({_asic_miner_id, e_value}, acc) ->
  #         e_coin_name = Map.get(e_value, :coin_name) |> String.downcase |> String.capitalize
  #         e_hash_rate = Map.get(e_value, :hashrate_5_min)
  #         e_hashrate_uom = Map.get(e_value, :hashrate_uom) |> String.downcase

  #         {e_unified_hashrate, e_unified_hashrate_uom} = Utility.unify_hashrate_to_hash_second(e_hash_rate, e_hashrate_uom)


  #         if Kernel.is_nil(Map.get(acc, e_coin_name, nil)) do
  #           Map.put(acc, e_coin_name, {e_unified_hashrate, e_unified_hashrate_uom})
  #         else
  #           {exist_hashrate, _exist_hashrate_uom} = Map.get(acc, e_coin_name)
  #           Map.put(acc, e_coin_name, {e_unified_hashrate + exist_hashrate, e_unified_hashrate_uom})
  #         end
  #       end)

  #   total_power =
  #     Enum.reduce(state, 0,
  #       fn({_e_key, e_value}, a) ->
  #         Map.get(e_value, :power)
  #         |> Kernel.+(a)
  #       end)

  #   total_asic_miner = Map.keys(asic_miner_map) |> Kernel.length()
  #   total_running_asic_miner =
  #     Enum.filter(asic_miner_operational_map, fn({_asic_miner_id, e_value}) ->
  #       Kernel.is_nil(e_value) == false
  #     end)
  #     |> Kernel.length()
  #   asic_miner_alive = "#{total_running_asic_miner}/#{total_asic_miner}"

  #   # data to broadcast
  #   #%{
  #   #  "asic_miner_map" = %{id => %asic_miner{}}
  #   #  "asic_miner_operational_map" => %{id => %asic_miner_log{}}
  #   #  "aggregated_index" => %{
  #   #    coin_hashrate_map => %{"coin_name" => {"hashrate", "uom"} },
  #   #    total_power => 1000
  #   #    asic_miner_alive => "2/3"
  #   #  }
  #   #}

  #   data = %{
  #     asic_miner_map: asic_miner_map,
  #     asic_miner_operational_map: asic_miner_operational_map,
  #     asic_miner_aggregated_index: %{
  #       coin_hashrate_map: coin_hashrate_map,
  #       total_power: total_power,
  #       asic_miner_alive: asic_miner_alive
  #     }
  #   }

  #   Phoenix.PubSub.broadcast(MiningRigMonitor.PubSub, "asic_miner_index_operational_channel",
  #     {:asic_miner_index_operational_channel , :operational_data, data})
  #   Process.send_after(__MODULE__, {:broadcast_operational_data}, 1_000)
  #   {:noreply, state}
  # end

  # def handle_info({:nillify_offline_miner}, state) do
  #   Logger.info("[CpuGpuMinerOperationalIndex][nillify_offline_miner] Starting.")
  #   now = NaiveDateTime.utc_now()
  #   new_state =
  #     Enum.reduce(state, %{}, fn({cpu_gpu_miner_id, cpu_gpu_miner_log}, acc) ->
  #       diff_time = NaiveDateTime.diff(now, cpu_gpu_miner_log.inserted_at, :second)
  #       if diff_time > 60  do
  #         acc
  #       else
  #         Map.put(acc, cpu_gpu_miner_id, cpu_gpu_miner_log)
  #       end
  #     end)
  #   Process.send_after(__MODULE__, {:nillify_offline_miner}, 15_000)
  #   {:noreply, new_state}
  # end
end
