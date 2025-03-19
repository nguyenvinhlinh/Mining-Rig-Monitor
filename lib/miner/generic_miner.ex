defmodule Miner.GenericMiner do
  @callback setup() :: nil
  @callback start_mining() :: nil
  @callback stop_mining() :: nil
end
