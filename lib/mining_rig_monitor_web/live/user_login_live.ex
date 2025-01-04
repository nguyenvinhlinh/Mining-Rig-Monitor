defmodule MiningRigMonitorWeb.UserLoginLive do
  use MiningRigMonitorWeb, :live_view_no_nav_layout

  def mount(_params, _session, socket) do
    email = Phoenix.Flash.get(socket.assigns.flash, :email)
    form = to_form(%{"email" => email}, as: "user")
    {:ok, assign(socket, form: form), temporary_assigns: [form: form]}
  end
end
