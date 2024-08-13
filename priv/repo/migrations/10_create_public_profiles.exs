defmodule Mkoussaelixir.Repo.Migrations.CreatePublicProfileTable do
  use Ecto.Migration

  def change do
    create table(:public_profile) do
      add :username, :string
      add :bio, :string
      add :online?, :boolean
      add :public_post_background_color, :string
      add :public_post_foreground_color, :string

      add :public_post_border_size, :integer
      add :public_post_border_type, :string
      add :public_post_border_color, :string

      add :chat_background_color_me, :string
      add :chat_foreground_color_me, :string
      add :chat_background_color_them, :string
      add :chat_foreground_color_them, :string
    end
  end
end
