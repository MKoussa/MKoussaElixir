defmodule MkoussaelixirWeb.RootLive.PublicFeed.Posts do
  use MkoussaelixirWeb, :html

  def list_posts(assigns) do
    ~H"""
    <div>
      <div :for={{dom_id, post} <- @posts} id={dom_id}>
        <p><%= post.content %></p>
      </div>
    </div>
    """
  end
end
