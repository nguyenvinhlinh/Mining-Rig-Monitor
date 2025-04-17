defmodule MiningRigMonitor.Utility do
  require Logger

  def unify_hashrate_uom("g"), do: "GH/s"
  def unify_hashrate_uom("G"), do: "GH/s"

  def unify_hashrate_uom(_), do: "H/s"

  def unify_hashrate_to_hash_second(hash, "g") when Kernel.is_number(hash) do
    {hash * 1_000_000_000, "H/s"}
  end
  def unify_hashrate_to_hash_second(hash, "gh/s") when Kernel.is_number(hash) do
    {hash * 1_000_000_000, "H/s"}
  end

  def unify_hashrate_to_hash_second(hash, unknow_uom) when Kernel.is_number(hash) do
    Logger.error("[MiningRigMonitor.Utility][convert_hashrate_to_hash_second/2]  #{unknow_uom} is not defined!")
    {hash, "H/s"}
  end

  def beautify_hashrate({hash, "H/s"}) do
    if hash > 1_000 do
      beautify_hashrate({hash / 1_000, "KH/s"})
    else
      {hash, "H/s"}
    end
  end

  def beautify_hashrate({hash, "KH/s"}) do
    if hash > 1_000 do
      beautify_hashrate({hash / 1_000, "MH/s"})
    else
      {hash, "KH/s"}
    end
  end

  def beautify_hashrate({hash, "MH/s"}) do
    if hash > 1_000 do
      beautify_hashrate({hash / 1_000, "GH/s"})
    else
      {hash, "MH/s"}
    end
  end

  def beautify_hashrate({hash, "GH/s"}) do
    if hash > 1_000 do
      beautify_hashrate({hash / 1_000, "TH/s"})
    else
      {hash, "TH/s"}
    end
  end

  def beautify_hashrate({hash, "TH/s"}) do
    if hash > 1_000 do
      beautify_hashrate({hash / 1_000, "PH/s"})
    else
      {hash, "TH/s"}
    end
  end

  def beautify_hashrate({hash, "PH/s"}) do
    {hash, "PH/s"}
  end

  def beautify_power_walt({power, "W"}) do
    if power > 10_000 do
      beautify_power_walt({power / 1_000, "KW"})
    else
      {power, "W"}
    end
  end
  def beautify_power_walt({power, "KW"}) do
    {power, "KW"}
  end

  def beautify_uptime(nil), do: "OFFLINE"
  def beautify_uptime("OFFLINE"), do: "OFFLINE"
  def beautify_uptime(""), do: "OFFLINE"

  def beautify_uptime(uptime) do
    [e1, e2, e3, _e4] = String.split(uptime, ":")
    "#{e1} day(s), #{e2} hour(s), #{e3} minute(s)"
  end

  def remove_diacritical_marks(string) when is_binary(string) do
    # á à ã ạ ả: dấu sắc, huyền, ngã, nặng, hỏi
    list_1 = [769, 768, 771, 803, 777]
    # â, ă, ư
    list_2 = [770, 774, 795]

    string
    |> String.normalize(:nfd)
    |> String.to_charlist()
    |> Enum.filter(fn(e) ->
      Enum.member?(list_1 ++ list_2, e) == false
    end)
    |> Kernel.to_string()
  end

end
