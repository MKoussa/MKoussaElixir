defmodule Mkoussaelixir.Posts do
  import Ecto.Query
  alias Mkoussaelixir.Accounts
  alias Mkoussaelixir.Repo

  alias Mkoussaelixir.Accounts.User
  alias Mkoussaelixir.Posts.{Post, Like}
  alias MkoussaelixirWeb.Endpoint

  @doc """
  Returns the list of posts.

  ## Examples

      iex> list_posts()
      [%Post{}, ...]

  """
  def list_posts do
    Repo.all(Post)
  end

  def get_post_count() do
    Repo.aggregate(Post, :count)
  end

  def like_count(%Post{} = post) do
    Like
    |> where([like], like.post_id == ^post.id)
    |> Repo.aggregate(:count)
  end

  def last_twenty_public_posts do
    Post
    |> order_by([p], {:desc, p.inserted_at})
    |> limit(20)
    |> preload(:poster)
    |> Repo.all()
  end

  def last_ten_public_posts_by_user_uuid(uuid) do
    poster = Accounts.get_user_by_uuid(uuid)

    Post
    |> where([p], p.poster_id == ^poster.id)
    |> order_by([p], {:desc, p.inserted_at})
    |> limit(10)
    |> preload(:poster)
    |> Repo.all()
  end

  @doc """
  Gets a single post.

  Raises `Ecto.NoResultsError` if the Post does not exist.

  ## Examples

      iex> get_post!(123)
      %Post{}

      iex> get_post!(456)
      ** (Ecto.NoResultsError)

  """
  def get_post!(id), do: Repo.get!(Post, id)

  def get_repost!(id) do
    Post
    |> preload(:poster)
    |> Repo.get(id)
  end

  @doc """
  Creates a post.

  ## Examples

      iex> create_post(%{field: value})
      {:ok, %Post{}}

      iex> create_post(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_post(attrs \\ %{}) do
    %Post{}
    |> Post.changeset(attrs)
    |> Repo.insert()
    |> publish_post_created()
  end

  def create_like(attrs \\ %{}) do
    %Like{}
    |> Like.changeset(attrs)
    |> Repo.insert()
    |> publish_like_created()
  end

  def already_liked?(%Post{} = post, %User{} = user) do
    query = from l in Like, where: l.liker_id == ^user.id and l.post_id == ^post.id
    Repo.exists?(query)
  end

  def average_like_color(%Post{} = post) do
    list_of_colors =
      Like
      |> where([like], like.post_id == ^post.id)
      |> Repo.all()
      |> Enum.map(fn like ->
        Integer.parse(String.slice(like.like_color, 1..6), 16) |> Tuple.to_list()
      end)
      |> List.flatten()
      |> Enum.filter(fn x -> x != "" end)

    avg_color = Statistics.median(list_of_colors)

    # Decimal.round(Decimal.new(avg_color)) |> IO.inspect()
    if is_nil(avg_color) do
      "888888"
    else
      Integer.to_string(trunc(avg_color), 16)
      |> String.pad_leading(6, "0")
    end
  end

  def publish_post_created({:ok, post} = result) do
    Endpoint.broadcast("public_post_feed", "post", %{post: post})
    result
  end

  def publish_post_created(result), do: result

  def publish_like_created({:ok, like} = result) do
    Endpoint.broadcast("post:#{like.post_id}", "like", %{like: like})
    result
  end

  def publish_like_created(result), do: result

  def preload_post_sender(post) do
    post
    |> Repo.preload(:poster)
  end

  @doc """
  Updates a post.

  ## Examples

      iex> update_post(post, %{field: new_value})
      {:ok, %Post{}}

      iex> update_post(post, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_post(%Post{} = post, attrs) do
    post
    |> Post.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a post.

  ## Examples

      iex> delete_post(post)
      {:ok, %Post{}}

      iex> delete_post(post)
      {:error, %Ecto.Changeset{}}

  """
  def delete_post(%Post{} = post) do
    Repo.delete(post)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking post changes.

  ## Examples

      iex> change_post(post)
      %Ecto.Changeset{data: %Post{}}

  """
  def change_post(%Post{} = post, attrs \\ %{}) do
    Post.changeset(post, attrs)
  end

  def like_changeset(%Like{} = like, attrs \\ %{}) do
    Like.changeset(like, attrs)
  end
end
