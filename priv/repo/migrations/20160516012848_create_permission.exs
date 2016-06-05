defmodule TriviaPhoenix.Repo.Migrations.CreatePermission do
  use Ecto.Migration

  def change do
    create table(:permissions) do
      add :role, :string, limit: 3
      add :room_id, references(:rooms)
      add :user_id, references(:users)
      timestamps
    end
    create unique_index(:permissions, [:room_id, :user_id])
    create index(:permissions, [:room_id])
    create index(:permissions, [:user_id])
  end
end
