import Config

# Note we also include the path to a cache manifest
# containing the digested version of static files. This
# manifest is generated by the `mix assets.deploy` task,
# which you should run after static files are built and
# before starting your production server.
config :mkoussaelixir, MkoussaelixirWeb.Endpoint,
  server: true,
  cache_static_manifest: "priv/static/cache_manifest.json",
  # Possibly not needed, but doesn't hurt
  http: [port: {:system, System.get_env("PORT")}],
  url: [host: System.get_env("APP_NAME") <> ".gigalixirapp.com", port: 443],
  secret_key_base: System.get_env("SECRET_KEY_BASE"),
  server: true

# Configures Swoosh API Client
config :swoosh, api_client: Swoosh.ApiClient.Finch, finch_name: Mkoussaelixir.Finch

# Disable Swoosh Local Memory Storage
config :swoosh, local: false

# Do not print debug messages in production
config :logger, level: :info

# Runtime production configuration, including reading
# of environment variables, is done on config/runtime.exs.

# Gigalixir
config :mkoussaelixir, Mkoussaelixir.Repo,
  adapter: Ecto.Adapters.Postgres,
  url: System.get_env("DATABASE_URL"),
  pool_size: System.get_env("POOL_SIZE")
