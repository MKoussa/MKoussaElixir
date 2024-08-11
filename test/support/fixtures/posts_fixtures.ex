defmodule Mkoussaelixir.PostsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Mkoussaelixir.Posts` context.
  """

  @doc """
  Generate a post.
  """
  def post_fixture(attrs \\ %{}) do
    {:ok, post} =
      attrs
      |> Enum.into(%{
        content: "some content",
        likes: %{},
        poster: "some poster"
      })
      |> Mkoussaelixir.Posts.create_post()

    post
  end
end
