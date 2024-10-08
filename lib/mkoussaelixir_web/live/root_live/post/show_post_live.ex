defmodule MkoussaelixirWeb.RootLive.Post.ShowPostLive do
  use MkoussaelixirWeb, :live_view

  alias MkoussaelixirWeb.Endpoint
  alias Mkoussaelixir.{Posts, Posts.Comment}
  alias Mkoussaelixir.Accounts

  def mount(%{"id" => id}, _session, socket) do
    if connected?(socket), do: Endpoint.subscribe("post:#{id}")
    if connected?(socket), do: Endpoint.subscribe("post-comment:#{id}")

    post = Mkoussaelixir.Posts.get_post_and_poster!(id)
    new_comment_form = Posts.comment_changeset(%Comment{})

    {:ok,
     socket
     |> assign(post: post)
     |> assign_comments_by_post_id(id)
     |> assign(new_comment_form: to_form(new_comment_form))}
  end

  def assign_comments_by_post_id(socket, post_id) do
    comments = Posts.get_comments(post_id)

    socket
    |> stream(:comments, comments)
  end

  def render(assigns) do
    ~H"""
    <p>
      Posted on
      <time datetime={@post.inserted_at}>
        <%= Calendar.strftime(@post.inserted_at, "%A, %B %d %Y at %I:%M %P") %>
      </time>
    </p>
    <.live_component
      id={"public-post:#{@post.id}"}
      module={MkoussaelixirWeb.RootLive.PublicFeed.Posts}
      liker={@current_user}
      repost_id={@post.repost_id}
      post={@post}
      show_repost_bubble={true}
      show_comment_bubble={false}
      poster_uuid={@post.poster.uuid}
      public_profile={@post.poster.public_profile}
      style="margin-bottom: 0.5%;"
    />
    <section>
      <div
        id="comments"
        style={"height: calc(60vh - 10rem);
               overflow: scroll;
               margin-left: 2rem;
               margin-right: 2rem;
               border: #{@post.poster.public_profile.public_post_border_size}px #{@post.poster.public_profile.public_post_border_type} #{@post.poster.public_profile.public_post_border_color};"}
        phx-update="stream"
      >
        <div :for={{dom_id, comment} <- @streams.comments} id={dom_id}>
          <.live_component
            id={"public-post-#{comment.post_id}-comment:#{comment.id}"}
            module={MkoussaelixirWeb.RootLive.Post.Comments}
            commenter_public_profile={comment.commenter.public_profile}
            comment={comment}
            poster_uuid={comment.commenter.uuid}
            public_profile={@post.poster.public_profile}
            style="margin-bottom: 0.5%;"
          />
        </div>
      </div>
    </section>
    <.live_component
      module={MkoussaelixirWeb.RootLive.PublicFeed.Post.Form}
      poster={@current_user}
      post_id={@post.id}
      new_post_form={@new_comment_form}
      id={"public-comment-form:#{@post.id}"}
    />
    """
  end

  def handle_info(%{event: "like", payload: %{like: like}}, socket) do
    post = Posts.get_post!(like.post_id)
    poster = Accounts.get_user!(post.poster_id)

    send_update(MkoussaelixirWeb.RootLive.PublicFeed.Posts,
      id: "public-post:#{like.post_id}",
      post: post,
      liker: socket.assigns.current_user,
      public_profile: Accounts.get_public_profile_by_user_uuid(poster.uuid),
      poster_uuid: poster.uuid
    )

    {:noreply, socket}
  end

  def handle_info(%{event: "comment", payload: %{comment: comment}}, socket) do
    {:noreply,
     socket
     |> insert_new_comment(comment)}
  end

  def insert_new_comment(socket, comment) do
    socket
    |> stream_insert(:comments, Posts.preload_post_commenter(comment), at: -1)
  end

  def handle_event("flip", %{"repost_id" => repost_id}, socket) do
    case Posts.create_post(%{
           poster_id: socket.assigns.current_user.id,
           content: "Repost",
           repost_id: String.to_integer(repost_id)
         }) do
      {:ok, _} ->
        {:noreply,
         socket
         |> put_flash(:info, "Repost Successful!")}

      {:error, error} ->
        {:noreply,
         socket
         |> put_flash(:error, error)}
    end
  end
end
