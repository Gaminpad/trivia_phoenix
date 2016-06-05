defmodule TriviaPhoenix.Permission do
  use TriviaPhoenix.Web, :model

  schema "permissions" do
    field :role, :string, limit: 3
    belongs_to :room, Room
    belongs_to :user, User
    timestamps
  end

  @required_fields ~w(role room_id user_id)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> unique_constraint(:room_id, :user_id)
  end

end
