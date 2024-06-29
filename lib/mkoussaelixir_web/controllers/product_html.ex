defmodule MkoussaelixirWeb.ProductHTML do
  use MkoussaelixirWeb, :html

  embed_templates "product_html/*"

  @doc """
  Renders a product form.
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true

  def product_form(assigns)
end
