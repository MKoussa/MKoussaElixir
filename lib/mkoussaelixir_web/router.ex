defmodule MkoussaelixirWeb.Router do
  use MkoussaelixirWeb, :router

  import MkoussaelixirWeb.UserAuth

  # -------- API -----------------
  pipeline :api do
    plug :accepts, ["json"]
    plug :fetch_current_api_user
  end

  scope "/api", MkoussaelixirWeb do
    pipe_through [:api, :require_authenticated_api_user]

    resources "/products", ProductAPIController, only: [:index, :show]
  end

  # ----------------- Browser -----------------
  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :fetch_current_user
  end

  pipeline :home do
    plug :put_root_layout, html: {MkoussaelixirWeb.Layouts, :root}
  end

  scope "/", MkoussaelixirWeb do
    pipe_through [:browser, :home]

    live_session :default,
      on_mount: [{MkoussaelixirWeb.UserAuth, :mount_current_user_and_uuid}] do
      live "/", PageLive
      live "/mkoussa", AboutLive
      live "/thermostat", ThermostatLive

      ## Authentication routes
      ## TODO move to seperate live_session scope
      live "/users/log_in", UserLoginLive, :new
      live "/users/register", UserRegistrationLive, :new
      live "/users/reset_password", UserForgotPasswordLive, :new
      live "/users/reset_password/:token", UserResetPasswordLive, :edit
      live "/users/settings", UserSettingsLive, :edit
      live "/users/settings/confirm_email/:token", UserSettingsLive, :confirm_email
      live "/users/orders", UserLive.UserOrdersLive
      live "/users/confirm/:token", UserConfirmationLive, :edit
      live "/users/confirm", UserConfirmationInstructionsLive, :new
    end

    delete "/users/log_out", UserSessionController, :delete
  end

  ## Authentication routes
  scope "/users", MkoussaelixirWeb do
    pipe_through [:browser, :redirect_if_user_is_authenticated, :home]

    post "/log_in", UserSessionController, :create
  end

  pipeline :blorp do
    plug :put_root_layout, html: {MkoussaelixirWeb.Layouts, :blorp}
  end

  scope "/blorp", MkoussaelixirWeb do
    pipe_through [:browser, :blorp]

    get "/", BlorpController, :index
    get "/original", BlorpController, :original
    get "/project_now", BlorpController, :now
  end

  live_session :shop,
    root_layout: {MkoussaelixirWeb.Layouts, :shop},
    on_mount: [{MkoussaelixirWeb.UserAuth, :mount_current_user_and_uuid}] do
    scope "/shop", MkoussaelixirWeb do
      pipe_through [:browser]

      live "/products", ShopLive.IndexProductLive
      live "/products/:id", ShopLive.ShowProductLive
      live "/cart", ShopLive.ShowCartLive
      live "/orders/:id", ShopLive.ShowOrdersLive
    end
  end

  live_session :default_loguesdk,
    root_layout: {MkoussaelixirWeb.Layouts, :loguesdk},
    on_mount: [] do
    scope "/loguesdk", MkoussaelixirWeb do
      pipe_through [:browser]

      live "/", LoguesdkLive.IndexLive
      live "/stuttermodeffect", LoguesdkLive.StutterModLive
      live "/reverseechodelayeffect", LoguesdkLive.ReverseEchoDelayLive
      live "/effects", LoguesdkLive.EffectsLive
      live "/oscillators", LoguesdkLive.OscillatorsLive
      live "/resources", LoguesdkLive.ResourcesLive
    end
  end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:mkoussaelixir, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through [:browser, :home]

      live_dashboard "/dashboard", metrics: {MkoussaelixirWeb.Telemetry, :metrics}
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
