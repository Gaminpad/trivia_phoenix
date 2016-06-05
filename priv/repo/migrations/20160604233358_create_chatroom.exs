defmodule TriviaPhoenix.Repo.Migrations.CreateChatroom do
  use Ecto.Migration

  def change do
    create table(:chatrooms) do
      add :url, :string
      add :topic, :string
      add :private, :boolean, default: false
      add :crypted_password, :string
      add :createdby_id, references(:users, on_delete: :nothing)

      timestamps
    end
    create index(:chatrooms, [:createdby_id])

  end
end
