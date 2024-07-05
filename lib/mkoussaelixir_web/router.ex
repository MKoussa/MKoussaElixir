defmodule MkoussaelixirWeb.Router do
  use MkoussaelixirWeb, :router

  # -------- API -----------------
  pipeline :api do
    plug :accepts, ["json"]
  end

  # Other scopes may use custom stacks.
  # scope "/api", MkoussaelixirWeb do
  #   pipe_through :api
  # end

  # ----------------- Browser -----------------
  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :home do
    plug :put_root_layout, html: {MkoussaelixirWeb.Layouts, :root}
  end

  scope "/", MkoussaelixirWeb do
    pipe_through [:browser, :home]

    get "/", PageController, :home
    get "/mkoussa", AboutController, :index
  end

  pipeline :shop do
    plug :fetch_current_user
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
      pipe_through :browser

      live_dashboard "/dashboard", metrics: MkoussaelixirWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end

  defp fetch_current_user(conn, _) do
    if user_uuid = get_session(conn, :current_uuid) do
      assign(conn, :current_uuid, user_uuid)
    else
      new_uuid = Ecto.UUID.generate()

      conn
      |> assign(:current_uuid, new_uuid)
      |> put_session(:current_uuid, new_uuid)
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
end
