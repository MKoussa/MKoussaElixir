defmodule MkoussaelixirWeb.CartHTML do
  use MkoussaelixirWeb, :html

  alias Mkoussaelixir.ShoppingCart

  embed_templates "cart_html/*"

  def currency_to_str(%Decimal{} = val) do
    "$#{Decimal.round(val, 2)}"
  end
end
