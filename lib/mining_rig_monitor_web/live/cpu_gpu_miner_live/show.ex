defmodule MiningRigMonitorWeb.CpuGpuMinerLive.Show do
  use MiningRigMonitorWeb, :live_view

  alias MiningRigMonitor.CpuGpuMiners

  embed_templates "show_html/*"

  @impl true
  def mount(%{"id" => cpu_gpu_miner_id}, _session, socket) do
    cpu_gpu_miner = CpuGpuMiners.get_cpu_gpu_miner!(cpu_gpu_miner_id)
    cpu_gpu_miner_log = empty_cpu_gpu_miner_log()

    if connected?(socket) do
      Phoenix.PubSub.subscribe(MiningRigMonitor.PubSub, "cpu_gpu_miner_operational_channel:#{cpu_gpu_miner.id}")
    end

    socket_mod = socket
    |> assign(:page_title, "Miner: #{cpu_gpu_miner.name}")
    |> assign(:cpu_gpu_miner, cpu_gpu_miner)
    |> assign(:cpu_gpu_miner_log, cpu_gpu_miner_log)
    {:ok, socket_mod}
  end

  @imple true
  def handle_info({:cpu_gpu_miner_operational_channel , :create_cpu_gpu_miner_log, cpu_gpu_miner_log}, socket) do
    socket_mod = socket
    |> assign(:cpu_gpu_miner_log, cpu_gpu_miner_log)
    {:noreply, socket_mod}
  end

  # @impl true
  # def handle_params(%{"id" => id}, _, socket) do
  #   {:noreply,
  #    socket
  #    |> assign(:page_title, page_title(socket.assigns.live_action))
  #    |> assign(:cpu_gpu_miner, CpuGpuMiners.get_cpu_gpu_miner!(id))}
  # end

  def empty_cpu_gpu_miner_log() do
    %MiningRigMonitor.CpuGpuMinerLogs.CpuGpuMinerLog{}
  end

  def sum_gpu_hashrate_1(cpu_gpu_miner_log) do
    gpu_hashrate_list = [
      cpu_gpu_miner_log.gpu_1_hashrate_1,
      cpu_gpu_miner_log.gpu_2_hashrate_1,
      cpu_gpu_miner_log.gpu_3_hashrate_1,
      cpu_gpu_miner_log.gpu_4_hashrate_1,
      cpu_gpu_miner_log.gpu_5_hashrate_1,
      cpu_gpu_miner_log.gpu_6_hashrate_1,
      cpu_gpu_miner_log.gpu_7_hashrate_1,
      cpu_gpu_miner_log.gpu_8_hashrate_1
    ]

    Enum.reduce(gpu_hashrate_list, 0, fn(e, a) ->
      if Kernel.is_nil(e), do: a, else: a + e
    end)
  end

  def sum_gpu_hashrate_2(cpu_gpu_miner_log) do
    gpu_hashrate_list = [
      cpu_gpu_miner_log.gpu_1_hashrate_2,
      cpu_gpu_miner_log.gpu_2_hashrate_2,
      cpu_gpu_miner_log.gpu_3_hashrate_2,
      cpu_gpu_miner_log.gpu_4_hashrate_2,
      cpu_gpu_miner_log.gpu_5_hashrate_2,
      cpu_gpu_miner_log.gpu_6_hashrate_2,
      cpu_gpu_miner_log.gpu_7_hashrate_2,
      cpu_gpu_miner_log.gpu_8_hashrate_2
    ]

    Enum.reduce(gpu_hashrate_list, 0, fn(e, a) ->
      if Kernel.is_nil(e), do: a, else: a + e
    end)
  end

  def sum_gpu_power(cpu_gpu_miner_log) do
    gpu_power_list = [
      cpu_gpu_miner_log.gpu_1_power,
      cpu_gpu_miner_log.gpu_2_power,
      cpu_gpu_miner_log.gpu_3_power,
      cpu_gpu_miner_log.gpu_4_power,
      cpu_gpu_miner_log.gpu_5_power,
      cpu_gpu_miner_log.gpu_6_power,
      cpu_gpu_miner_log.gpu_7_power,
      cpu_gpu_miner_log.gpu_8_power
    ]

    Enum.reduce(gpu_power_list, 0, fn(e, a) ->
      if Kernel.is_nil(e), do: a, else: a + e
    end)
  end

  def sum_total_power(cpu_gpu_miner_log) do
    power_list = [
      cpu_gpu_miner_log.cpu_power,
      cpu_gpu_miner_log.gpu_1_power,
      cpu_gpu_miner_log.gpu_2_power,
      cpu_gpu_miner_log.gpu_3_power,
      cpu_gpu_miner_log.gpu_4_power,
      cpu_gpu_miner_log.gpu_5_power,
      cpu_gpu_miner_log.gpu_6_power,
      cpu_gpu_miner_log.gpu_7_power,
      cpu_gpu_miner_log.gpu_8_power
    ]

    Enum.reduce(power_list, 0, fn(e, a) ->
      if Kernel.is_nil(e), do: a, else: a + e
    end)
  end
end
