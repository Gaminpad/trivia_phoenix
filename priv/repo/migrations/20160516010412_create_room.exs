defmodule TriviaPhoenix.Repo.Migrations.CreateRoom do
  use Ecto.Migration

  def change do
    create table(:rooms) do
      add :slug, :string, limit: 32
      add :name, :string
      timestamps
    end
    create unique_index(:rooms, [:slug])
  end

end
