defmodule Miner.XMRIG_6_22_2 do
 # @behaviour Miners.GenericMiner
  require Logger
  alias HTTPoison.Response

  @url "https://github.com/xmrig/xmrig/releases/download/v6.22.2/xmrig-6.22.2-linux-static-x64.tar.gz"
  @download_filename "xmrig-6.22.2-linux-static-x64.tar.gz"
  @executable_miner_file_path "/tmp/miner_softwares/xmrig-6.22.2/xmrig"

  #@impl Miners.GenericMiner
  def setup do
    {:ok, download_file_path} = download_miner(@url, @download_filename)

    installation_path = Application.get_env(:cpu_gpu_sentry, :installation_path)
    miner_softwares_directory = Path.join([installation_path, "miner_softwares"])
    :ok = extract_file_tar(download_file_path, miner_softwares_directory)
  end

  #  @impl Miners.GenericMiner
  def start_mining(args_list) when Kernel.is_list(args_list) do
    installation_path = Application.get_env(:cpu_gpu_sentry, :installation_path)
    wrapper_script_path = Path.join([installation_path, "miner_softwares", "wrapper.sh"])

    mod_args_list = [@executable_miner_file_path] ++ args_list
    port = Port.open({:spawn_executable, wrapper_script_path}, [:binary, args: mod_args_list])
    port
  end

  def download_miner(url, saved_filename) do
    saved_path_filename = Path.join(["/tmp", saved_filename])
    with {:ok, %Response{status_code: 200, body: data}} <- http_get(url),
         :ok <- write_file(saved_path_filename, data) do
      {:ok, saved_path_filename}
    else
      error ->
        IO.inspect "DEBUG #{__ENV__.file} @#{__ENV__.line}"
        IO.inspect error
        IO.inspect "END"
        error
    end
  end

  def extract_file_tar(file_tar_path, target_directory_path) do
    Logger.info("[XMRIG_6_22_2] Extract file #{file_tar_path} to #{target_directory_path}")
    :erl_tar.extract(file_tar_path, [{:cwd, target_directory_path}, :compressed])
  end

  defp http_get(url) do
    Logger.info("[XMRIG_6_22_2] Downloading #{url}")
    HTTPoison.get(url, [], follow_redirect: true)
  end

  defp write_file(saved_path_filename, data) do
    Logger.info("[XMRIG_6_22_2] Writing to #{saved_path_filename}")
    File.write(saved_path_filename, data)
  end


  def test_start_mining() do
    args_list = [
      "--no-color",
      "--url", "pool.hashvault.pro:443",
      "--algo", "rx/0",
      "--user", "49gTVubHUbS4QqceSqLQ57LTf7K1eqdipKikuwiLUWx3CHUf2qCsRDX4jSV465we65Uv5k7D3YPtNfBGKv981PZYPkrhWLg",
      "--pass", "miner_name_X"
    ]

    start_mining(args_list)
  end

  def print_miner_logs() do
    receive do
      {_, {:data, msg}} ->
        IO.write(msg)
        print_miner_logs()
    after
      5000 ->
        IO.puts(:stderr, "No message in 5 seconds")
    end
  end
end
