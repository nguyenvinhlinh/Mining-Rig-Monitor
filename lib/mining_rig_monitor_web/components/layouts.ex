defmodule MiningRigMonitorWeb.Layouts do
  @moduledoc """
  This module holds different layouts used by your application.

  See the `layouts` directory for all templates available.
  The "root" layout is a skeleton rendered as part of the
  application router. The "app" layout is set as the default
  layout on both `use MiningRigMonitorWeb, :controller` and
  `use MiningRigMonitorWeb, :live_view`.
  """
  use MiningRigMonitorWeb, :html

  embed_templates "layouts/*"

  def login(assigns) do
    ~H"""
    {render_slot(@inner_block)}
    <.nx_flash_group flash={@flash} />
    """
  end

  def nexus_app(assigns) do
    ~H"""
    <.nx_flash_group flash={@flash} />
    <.live_component module={MiningRigMonitorWeb.Layouts.NexusTopbarLiveComponent} id="nexus_topbar" current_user={@current_user}/>
    {render_slot(@inner_block)}

    """
  end
end
