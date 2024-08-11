defmodule MkoussaelixirWeb.RootLive.PublicFeed.Posts do
  use MkoussaelixirWeb, :html

  def list_posts(assigns) do
    ~H"""
    <div style="height: calc(60vh - 10rem); overflow: scroll;">
      <div :for={{dom_id, post} <- @posts} id={dom_id}>
        <.post_details
          content={post.content}
          poster_username={post.poster.public_profile.username}
          post_date={post.inserted_at}
          poster_profile={post.poster.uuid}
        />
      </div>
    </div>
    """
  end

  def post_details(assigns) do
    ~H"""
    <div style="display: block; border: 2px dotted var(--base-purple); border-radius: 5px; margin: 1%; padding: 1%;">
      <span>
        On <%= @post_date %>,
        <strong>
          <.link patch={~p"/users/public_profile/#{@poster_profile}"}><%= @poster_username %></.link>
        </strong>
        posted:
      </span>
      <br />
      <p><%= @content %></p>
    </div>
    """
  end
end
