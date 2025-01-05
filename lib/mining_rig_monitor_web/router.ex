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

  ## Authentication routes

  scope "/", MiningRigMonitorWeb do
    pipe_through [:browser, :redirect_if_user_is_authenticated]

    live_session :redirect_if_user_is_authenticated,
      on_mount: [{MiningRigMonitorWeb.UserAuth, :redirect_if_user_is_authenticated}],
      root_layout: {MiningRigMonitorWeb.Layouts, :root_no_nav} do

      live "/users/register", UserRegistrationLive, :new
      live "/users/log_in", UserLoginLive, :new
      live "/users/reset_password", UserForgotPasswordLive, :new
      live "/users/reset_password/:token", UserResetPasswordLive, :edit
    end

    post "/users/log_in", UserSessionController, :create
  end

  scope "/", MiningRigMonitorWeb do
    pipe_through [:browser, :require_authenticated_user]

    live_session :require_authenticated_user,
      on_mount: [{MiningRigMonitorWeb.UserAuth, :ensure_authenticated}] do
      live "/users/settings", UserSettingsLive, :edit
      live "/users/settings/confirm_email/:token", UserSettingsLive, :confirm_email
    end
  end

  scope "/", MiningRigMonitorWeb do
    pipe_through [:browser]

    delete "/users/log_out", UserSessionController, :delete

    live_session :current_user,
      on_mount: [{MiningRigMonitorWeb.UserAuth, :mount_current_user}] do
      live "/users/confirm/:token", UserConfirmationLive, :edit
      live "/users/confirm", UserConfirmationInstructionsLive, :new
    end
  end
end
