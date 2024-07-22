defmodule MiningRigMonitorWeb.Router do
  use MiningRigMonitorWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {MiningRigMonitorWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug MiningRigMonitorWeb.Plugs.MiningRigCodeAuthentication
  end

  scope "/", MiningRigMonitorWeb do
    pipe_through :browser

    get "/", PageController, :home
    get "/flowbite", FlowbiteController, :flowbite

    live "/mining_rigs", MiningRigLive.Index, :index
    live "/mining_rigs/new", MiningRigLive.Index, :new
    live "/mining_rigs/:id/edit", MiningRigLive.Index, :edit
    live "/mining_rigs/:id/pre_delete", MiningRigLive.Index, :pre_delete

    live "/mining_rigs/:id", MiningRigLive.Show, :show
    live "/mining_rigs/:id/show/edit", MiningRigLive.Show, :edit

    live "/mining_rigs/asic/:id", MiningRigLive.ShowAsic, :show
  end

  scope "/api/v1" do
    pipe_through :api
    # post "/asic_spec", MiningRigMonitorWeb.AsicRigMonitorRecordController, :save
    post "/asic_rig_monitor_records", MiningRigMonitorWeb.AsicRigMonitorRecordController, :save
    scope "/mining_rig" do
      post "/asic_spec", MiningRigMonitorWeb.MiningRigController, :update_mining_rig_asic
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
end
