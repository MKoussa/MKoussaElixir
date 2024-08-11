defmodule Mkoussaelixir.PostsTest do
  use Mkoussaelixir.DataCase

  alias Mkoussaelixir.Posts

  describe "posts" do
    alias Mkoussaelixir.Posts.Post

    import Mkoussaelixir.PostsFixtures

    @invalid_attrs %{}

    test "list_posts/0 returns all posts" do
      post = post_fixture()
      assert Posts.list_posts() == [post]
    end

    test "get_post!/1 returns the post with given id" do
      post = post_fixture()
      assert Posts.get_post!(post.id) == post
    end

    test "create_post/1 with valid data creates a post" do
      valid_attrs = %{}

      assert {:ok, %Post{} = post} = Posts.create_post(valid_attrs)
    end

    test "create_post/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Posts.create_post(@invalid_attrs)
    end

    test "update_post/2 with valid data updates the post" do
      post = post_fixture()
      update_attrs = %{}

      assert {:ok, %Post{} = post} = Posts.update_post(post, update_attrs)
    end

    test "update_post/2 with invalid data returns error changeset" do
      post = post_fixture()
      assert {:error, %Ecto.Changeset{}} = Posts.update_post(post, @invalid_attrs)
      assert post == Posts.get_post!(post.id)
    end

    test "delete_post/1 deletes the post" do
      post = post_fixture()
      assert {:ok, %Post{}} = Posts.delete_post(post)
      assert_raise Ecto.NoResultsError, fn -> Posts.get_post!(post.id) end
    end

    test "change_post/1 returns a post changeset" do
      post = post_fixture()
      assert %Ecto.Changeset{} = Posts.change_post(post)
    end
  end

  describe "posts" do
    alias Mkoussaelixir.Posts.Post

    import Mkoussaelixir.PostsFixtures

    @invalid_attrs %{poster: nil, content: nil, likes: nil}

    test "list_posts/0 returns all posts" do
      post = post_fixture()
      assert Posts.list_posts() == [post]
    end

    test "get_post!/1 returns the post with given id" do
      post = post_fixture()
      assert Posts.get_post!(post.id) == post
    end

    test "create_post/1 with valid data creates a post" do
      valid_attrs = %{poster: "some poster", content: "some content", likes: %{}}

      assert {:ok, %Post{} = post} = Posts.create_post(valid_attrs)
      assert post.poster == "some poster"
      assert post.content == "some content"
      assert post.likes == %{}
    end

    test "create_post/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Posts.create_post(@invalid_attrs)
    end

    test "update_post/2 with valid data updates the post" do
      post = post_fixture()
      update_attrs = %{poster: "some updated poster", content: "some updated content", likes: %{}}

      assert {:ok, %Post{} = post} = Posts.update_post(post, update_attrs)
      assert post.poster == "some updated poster"
      assert post.content == "some updated content"
      assert post.likes == %{}
    end

    test "update_post/2 with invalid data returns error changeset" do
      post = post_fixture()
      assert {:error, %Ecto.Changeset{}} = Posts.update_post(post, @invalid_attrs)
      assert post == Posts.get_post!(post.id)
    end

    test "delete_post/1 deletes the post" do
      post = post_fixture()
      assert {:ok, %Post{}} = Posts.delete_post(post)
      assert_raise Ecto.NoResultsError, fn -> Posts.get_post!(post.id) end
    end

    test "change_post/1 returns a post changeset" do
      post = post_fixture()
      assert %Ecto.Changeset{} = Posts.change_post(post)
    end
  end
end
