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

    get "/", PageController, :home
    get "/mkoussa", AboutController, :index
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

  pipeline :shop do
    plug :fetch_current_cart
    plug :put_root_layout, html: {MkoussaelixirWeb.Layouts, :shop}
  end

  scope "/shop", MkoussaelixirWeb do
    pipe_through [:browser, :shop]

    resources "/products", ProductController
    resources "/cart_items", CartItemController, only: [:create, :delete]

    get "/cart", CartController, :show
    put "/cart", CartController, :update

    resources "/orders", OrderController, only: [:create, :show]
  end

  pipeline :loguesdk do
    plug :put_root_layout, html: {MkoussaelixirWeb.Layouts, :loguesdk}
  end

  scope "/loguesdk", MkoussaelixirWeb do
    pipe_through [:browser, :loguesdk]

    get "/", LoguesdkController, :index
    get "/stuttermodeffect", LoguesdkController, :stutter_mod_fx
    get "/reverseechodelayeffect", LoguesdkController, :reverse_echo_delay_fx
    get "/effects", LoguesdkController, :fx
    get "/oscillators", LoguesdkController, :oscillators
    get "/resources", LoguesdkController, :resources
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

  alias Mkoussaelixir.ShoppingCart

  defp fetch_current_cart(conn, _opts) do
    if cart = ShoppingCart.get_cart_by_user_uuid(conn.assigns.current_uuid) do
      assign(conn, :cart, cart)
    else
      {:ok, new_cart} = ShoppingCart.create_cart(conn.assigns.current_uuid)
      assign(conn, :cart, new_cart)
    end
  end

  ## Authentication routes

  scope "/", MkoussaelixirWeb do
    pipe_through [:browser, :redirect_if_user_is_authenticated, :home]

    get "/users/register", UserController, :new_registration
    post "/users/register", UserController, :create_registration
    get "/users/log_in", UserController, :new_session
    post "/users/log_in", UserController, :create_session
    get "/users/reset_password", UserController, :new_reset_password
    post "/users/reset_password", UserController, :create_reset_password
    get "/users/reset_password/:token", UserController, :edit_reset_password
    put "/users/reset_password/:token", UserController, :update_reset_password
  end

  scope "/", MkoussaelixirWeb do
    pipe_through [:browser, :require_authenticated_user, :home]

    get "/users/settings", UserController, :edit_settings
    put "/users/settings", UserController, :update_settings
    get "/users/settings/confirm_email/:token", UserController, :confirm_email

    get "/users/orders", UserController, :show_orders
  end

  scope "/", MkoussaelixirWeb do
    pipe_through [:browser, :home]

    delete "/users/log_out", UserController, :delete_session
    get "/users/confirm", UserController, :new_confirmation
    post "/users/confirm", UserController, :create_confirmation
    get "/users/confirm/:token", UserController, :edit_confirmation
    post "/users/confirm/:token", UserController, :update_confirmation
  end
end
