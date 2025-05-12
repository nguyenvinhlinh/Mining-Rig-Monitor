defmodule MiningRigMonitorWeb.Router do
  use MiningRigMonitorWeb, :router

  import MiningRigMonitorWeb.UserAuth

  pipeline :nexus_browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {MiningRigMonitorWeb.Layouts, :nexus_root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :fetch_current_user
  end

  pipeline :nexus_no_nav_layout do
    plug :put_root_layout, html: {MiningRigMonitorWeb.Layouts, :nexus_root_no_nav}
  end

  pipeline :api_asic_miner do
    plug :accepts, ["json"]
    plug MiningRigMonitorWeb.Plugs.ApiCodeAuthentication, :asic_miner
  end

  pipeline :api_cpu_gpu_miner do
    plug :accepts, ["json"]
    plug MiningRigMonitorWeb.Plugs.ApiCodeAuthentication, :cpu_gpu_miner
  end

  scope "/", MiningRigMonitorWeb do
    pipe_through [:nexus_browser, :require_authenticated_user]

    live "/",                     AsicMinerLive.Index, :index
    live "/asic_miners",          AsicMinerLive.Index, :index
    live "/asic_miners/new",      AsicMinerLive.New,   :new
    live "/asic_miners/:id/edit", AsicMinerLive.Edit,  :edit
    live "/asic_miners/:id",      AsicMinerLive.Show,  :show

    live "/cpu_gpu_miners",          CpuGpuMinerLive.Index, :index
    live "/cpu_gpu_miners/new",      CpuGpuMinerLive.New,   :new
    live "/cpu_gpu_miners/:id/edit", CpuGpuMinerLive.Edit,  :edit
    live "/cpu_gpu_miners/:id",      CpuGpuMinerLive.Show,  :show

    live "/addresses",            AddressLive.Index, :index
    live "/addresses/new_wallet", AddressLive.New,   :new_wallet
    live "/addresses/new_pool",   AddressLive.New,   :new_pool
    live "/addresses/:id/edit",   AddressLive.Edit,  :edit

    live "/cpu_gpu_miners/:cpu_gpu_miner_id/playbooks",                   CpuGpuMinerPlaybookLive.Index, :index
    live "/cpu_gpu_miners/:cpu_gpu_miner_id/playbooks/new",               CpuGpuMinerPlaybookLive.New,   :new
    live "/cpu_gpu_miners/:cpu_gpu_miner_id/playbooks/:playbook_id",      CpuGpuMinerPlaybookLive.Show,  :show
    live "/cpu_gpu_miners/:cpu_gpu_miner_id/playbooks/:playbook_id/edit", CpuGpuMinerPlaybookLive.Edit,  :edit

    live "/users/settings", UserSettingsLive, :edit
  end

  scope "/", MiningRigMonitorWeb do
    pipe_through [:nexus_browser, :nexus_no_nav_layout]

    live "/users/log_in", UserLoginLive, :new
    post "/users/log_in", UserSessionController, :create
    delete "/users/log_out", UserSessionController, :delete
  end

  scope "/api/v1" do
    get "/ping", MiningRigMonitorWeb.PingPongController, :ping
    post "/asic_miners/expected_status_bulk", MiningRigMonitorWeb.AsicMinerController, :get_expected_status_bulk

    scope "/asic_miners" do
      pipe_through :api_asic_miner
      post "/specs",           MiningRigMonitorWeb.AsicMinerController, :update_asic_miner_specs
      get  "/expected_status", MiningRigMonitorWeb.AsicMinerController, :get_expected_status
      post "/logs",            MiningRigMonitorWeb.AsicMinerLogController, :create
    end

    scope "/cpu_gpu_miners" do
      pipe_through :api_cpu_gpu_miner
      post "/specs",    MiningRigMonitorWeb.CpuGpuMinerController, :update_cpu_gpu_miner_specs
      post "/logs",     MiningRigMonitorWeb.CpuGpuMinerLogController, :create
      get "/playbooks", MiningRigMonitorWeb.CpuGpuMinerPlaybookController, :get_playbook_list
      get "/playbooks/:playbook_id/module", MiningRigMonitorWeb.CpuGpuMinerPlaybookController, :get_playbook_module_binary
    end
  end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:mining_rig_monitor, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :nexus_browser

      live_dashboard "/dashboard", metrics: MiningRigMonitorWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
