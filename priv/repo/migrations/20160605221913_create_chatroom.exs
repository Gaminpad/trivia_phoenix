defmodule TriviaPhoenix.Repo.Migrations.CreateChatroom do
  use Ecto.Migration

  def change do
    create table(:chatrooms) do
      add :url, :string
      add :topic, :string
      add :private, :boolean, default: false
      add :encrypt_password, :string
      add :description, :text
      add :user_id, references(:users, on_delete: :nothing)

      timestamps
    end
    create index(:chatrooms, [:user_id])
    create unique_index(:chatrooms, [:url])

  end
end
