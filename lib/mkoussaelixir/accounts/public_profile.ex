defmodule Mkoussaelixir.Accounts.PublicProfile do
  use Ecto.Schema
  import Ecto.Changeset

  embedded_schema do
    field :username, :string, default: "New User"
    field :bio, :string, default: "There's nothing here..."
    field :online?, :boolean, default: false

    field :public_post_background_color, :string
    field :public_post_foreground_color, :string
    field :public_post_border_size, :integer

    field :public_post_border_type, Ecto.Enum,
      values: [
        :none,
        :hidden,
        :dotted,
        :dashed,
        :solid,
        :double,
        :groove,
        :ridge,
        :inset,
        :outset
      ]

    field :public_post_border_color, :string

    field :chat_background_color_me, :string
    field :chat_foreground_color_me, :string
    field :chat_background_color_them, :string
    field :chat_foreground_color_them, :string
  end

  def changeset(profile, attrs \\ %{}) do
    profile
    |> cast(attrs, [
      :username,
      :bio,
      :online?,
      :public_post_background_color,
      :public_post_foreground_color,
      :chat_background_color_me,
      :chat_foreground_color_me,
      :chat_background_color_them,
      :chat_foreground_color_them
    ])
    |> validate_length(:public_post_background_color, is: 7)
    |> validate_length(:public_post_foreground_color, is: 7)
    |> validate_length(:chat_background_color_me, is: 7)
    |> validate_length(:chat_foreground_color_me, is: 7)
    |> validate_length(:chat_background_color_them, is: 7)
    |> validate_length(:chat_foreground_color_them, is: 7)
  end
end
