defmodule MiningRigMonitorWeb.Router do
  use MiningRigMonitorWeb, :router

  import MiningRigMonitorWeb.UserAuth

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {MiningRigMonitorWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :fetch_current_user
  end

  pipeline :no_nav_layout do
    plug :put_root_layout, html: {MiningRigMonitorWeb.Layouts, :root_no_nav}
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug MiningRigMonitorWeb.Plugs.MiningRigCodeAuthentication
  end

  pipeline :api_asic_miner do
    plug :accepts, ["json"]
    plug MiningRigMonitorWeb.Plugs.ApiCodeAuthentication, :asic_miner
  end
  scope "/", MiningRigMonitorWeb do
    pipe_through [:browser, :no_nav_layout]

    get "/", PageController, :home
    get "/flowbite", FlowbiteController, :flowbite
  end

  scope "/", MiningRigMonitorWeb do
    pipe_through [:browser, :require_authenticated_user]
    live "/asic_miners", AsicMinerLive.Index, :index
    live "/asic_miners/new", AsicMinerLive.Index, :new
    live "/asic_miners/:id/edit", AsicMinerLive.Index, :edit

    live "/asic_miners/:id", AsicMinerLive.Show, :show
    live "/asic_miners/:id/show/edit", AsicMinerLive.Show, :edit

  end

  scope "/api/v1" do
    scope "/asic_miners" do
      pipe_through :api_asic_miner
      post "/specs", MiningRigMonitorWeb.AsicMinerController, :update_asic_miner_specs
      post "/logs",  MiningRigMonitorWeb.AsicMinerLogController, :create
    end
  end




  # Other scopes may use custom stacks.
  # scope "/api", MiningRigMonitorWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:mining_rig_monitor, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: MiningRigMonitorWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end

  ## Authentication routes

  scope "/", MiningRigMonitorWeb do
    pipe_through [:browser, :redirect_if_user_is_authenticated]

    live_session :redirect_if_user_is_authenticated,
      on_mount: [{MiningRigMonitorWeb.UserAuth, :redirect_if_user_is_authenticated}],
      root_layout: {MiningRigMonitorWeb.Layouts, :root_no_nav} do
      live "/users/register", UserRegistrationLive, :new
      live "/users/log_in", UserLoginLive, :new
    end

    post "/users/log_in", UserSessionController, :create
  end

  scope "/", MiningRigMonitorWeb do
    pipe_through [:browser, :require_authenticated_user]

    live_session :require_authenticated_user,
      on_mount: [{MiningRigMonitorWeb.UserAuth, :ensure_authenticated}] do
      live "/users/settings", UserSettingsLive, :edit
    end
  end

  scope "/", MiningRigMonitorWeb do
    pipe_through [:browser]

    delete "/users/log_out", UserSessionController, :delete
  end
end
