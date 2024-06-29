defmodule Mkoussaelixir.CatalogFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Mkoussaelixir.Catalog` context.
  """

  @doc """
  Generate a product.
  """
  def product_fixture(attrs \\ %{}) do
    {:ok, product} =
      attrs
      |> Enum.into(%{
        category: "some category",
        description: "some description",
        price: "120.5",
        title: "some title",
        views: 42
      })
      |> Mkoussaelixir.Catalog.create_product()

    product
  end
end
