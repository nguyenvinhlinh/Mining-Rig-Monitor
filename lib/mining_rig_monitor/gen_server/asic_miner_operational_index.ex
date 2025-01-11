defmodule MiningRigMonitor.GenServer.AsicMinerOperationalIndex do
  use GenServer
  alias MiningRigMonitor.AsicMinerLogs.AsicMinerLog
  require Logger
  #interface
  def start_link(_args), do: start_link()
  def start_link() do
    {:ok, pid} = GenServer.start_link(__MODULE__, nil, name: __MODULE__)
    Logger.info("[AsicMinerOperationalIndex] started")
    {:ok, pid}
  end

  def get(asic_miner_id) when Kernel.is_integer(asic_miner_id) do
    GenServer.call(__MODULE__, {:get, asic_miner_id})
  end

  def take(asic_miner_id_list) when Kernel.is_list(asic_miner_id_list) do
    GenServer.call(__MODULE__, {:take, asic_miner_id_list})
  end

  def get_all() do
    GenServer.call(__MODULE__, {:get_all})
  end

  def put(%AsicMinerLog{} = asic_miner_log) do
    GenServer.cast(__MODULE__, {:put, asic_miner_log})
  end


  #callback
  @impl true
  def init(_) do
    {:ok, %{}}
  end

  @impl true
  def handle_cast({:put, %AsicMinerLog{} = asic_miner_log}, state) do
    state_mod = state
    |> Map.put(asic_miner_log.asic_miner_id, asic_miner_log)
    {:noreply, state_mod}
  end

  @impl true
  def handle_call({:get, asic_miner_id}, _pid, state) when Kernel.is_integer(asic_miner_id)do
    asic_miner_log = Map.get(state, asic_miner_id)
    {:reply, asic_miner_log, state}
  end

  @impl true
  def handle_call({:take, asic_miner_id_list}, _pid,  state) when Kernel.is_list(asic_miner_id_list) do
    asic_miner_log_map = Map.take(state, asic_miner_id_list)
    {:reply, asic_miner_log_map, state}
  end

  @impl true
  def handle_call({:get_all}, _pid, state), do: {:reply, state, state}
end
