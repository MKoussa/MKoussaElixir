defmodule Mkoussaelixir.ShoppingCartFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Mkoussaelixir.ShoppingCart` context.
  """

  @doc """
  Generate a unique cart user_uuid.
  """
  def unique_cart_user_uuid, do: "some user_uuid#{System.unique_integer([:positive])}"

  @doc """
  Generate a cart.
  """
  def cart_fixture(attrs \\ %{}) do
    {:ok, cart} =
      attrs
      |> Enum.into(%{
        user_uuid: unique_cart_user_uuid()
      })
      |> Mkoussaelixir.ShoppingCart.create_cart()

    cart
  end

  @doc """
  Generate a cart_item.
  """
  def cart_item_fixture(attrs \\ %{}) do
    {:ok, cart_item} =
      attrs
      |> Enum.into(%{
        price_when_carted: "120.5",
        quantity: 42
      })
      |> Mkoussaelixir.ShoppingCart.create_cart_item()

    cart_item
  end
end
