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
          background_color={post.poster.public_profile.public_post_background_color}
          color={post.poster.public_profile.public_post_foreground_color}
          border_size={post.poster.public_profile.public_post_border_size}
          border_type={post.poster.public_profile.public_post_border_type}
          border_color={post.poster.public_profile.public_post_border_color}
        />
      </div>
    </div>
    """
  end

  def post_details(assigns) do
    ~H"""
    <div style={"display: block;
                 margin: 1%;
                 padding: 1%;
                 word-break: break-word;
                 background-color: #{@background_color};
                 color: #{@color};
                 border: #{@border_size}px #{@border_type} #{@border_color};"}>
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
