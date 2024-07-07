defmodule MkoussaelixirWeb.ProductAPIJSON do
  alias Mkoussaelixir.Catalog.Product

  @doc """
  Renders a list of products.
  """
  def index(%{products: products}) do
    %{products: for(product <- products, do: data(product))}
  end

  @doc """
  Renders a single product_api.
  """
  def show(%{product: product}) do
    %{product: data(product)}
  end

  defp data(%Product{} = product) do
    %{
      id: product.id,
      title: product.title,
      description: product.description,
      price: product.price,
      categories: product.categories
    }
  end
end
