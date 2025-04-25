defmodule MiningRigMonitorWeb.Layouts.NexusTopbarLiveComponent do
  use MiningRigMonitorWeb, :live_component

  @impl true
  def mount(socket) do
    IO.inspect "DEBUG #{__ENV__.file} @#{__ENV__.line}"
    IO.inspect socket
    IO.inspect "END"
    {:ok, socket}
  end
end
