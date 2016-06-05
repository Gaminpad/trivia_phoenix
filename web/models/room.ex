defmodule TriviaPhoenix.Room do
  use TriviaPhoenix.Web, :model
  use Ecto.Model.Callbacks
  import Ecto.Changeset

  schema "rooms" do
    field :slug, :string, limit: 32
    field :name, :string
    has_many :permissions, Permission
    timestamps
  end

  before_insert :generate_slug

  @required_fields ~w( slug name )
  @optional_fields ~w()

  def create(changeset, user) do
    changeset
    |> TriviaPhoenix.Repo.insert()
    |> create_permission(user, :own)
    changeset
  end


  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> unique_constraint(:slug)
  end

  defp slugify(name) do
    name
    |> String.strip
    |> String.normalize(:nfd)
    |> String.replace(~r/[^A-z\s]/u, "")
    |> String.replace(~r/\s/, "-")
  end

  defp generate_slug(model) do
    model
    |> put_change(:slug, slugify(model.params["name"]))
  end

  defp create_permission(model, user, role \\ :own) do
    Permision.create()
  end

end
