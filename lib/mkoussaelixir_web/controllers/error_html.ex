defmodule MkoussaelixirWeb.ErrorHTML do
  @moduledoc """
  This module is invoked by your endpoint in case of errors on HTML requests.

  See config/config.exs.
  """
  use MkoussaelixirWeb, :html

  embed_templates "error_html/*"
end
