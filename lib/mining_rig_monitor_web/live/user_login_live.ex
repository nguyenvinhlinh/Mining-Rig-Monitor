defmodule MiningRigMonitorWeb.UserLoginLive do
  use MiningRigMonitorWeb, :live_view
  require Logger

  on_mount {MiningRigMonitorWeb.UserAuth, :redirect_if_user_is_authenticated}

  def mount(_params, _session, socket) do
    email = Phoenix.Flash.get(socket.assigns.flash, :email)
    form = to_form(%{"email" => email}, as: "user")

    socket_mod = socket
    |> assign(:form, form)

    {:ok, socket_mod, temporary_assigns: [form: form]}
  end
end
