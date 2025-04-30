defmodule MiningRigMonitorWeb.UserAuthLive do
  import Phoenix.Component, only: [assign_new: 3]
  alias MiningRigMonitor.Accounts

  def on_mount(:default, _params, %{"user_token" => user_token} = _session, socket) do
    current_user = Accounts.get_user_by_session_token(user_token)
    socket_mod = socket
    |> assign_new(:current_user, fn() -> current_user end)
    {:cont, socket_mod}
  end
end
