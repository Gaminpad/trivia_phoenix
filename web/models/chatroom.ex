defmodule TriviaPhoenix.Room do
  use TriviaPhoenix.Web, :model

  schema "chatrooms" do
    field :url, :string
    field :topic, :string
    field :private, :boolean, default: false
    field :crypted_password, :string
    belongs_to :createdby, TriviaPhoenix.Createdby

    timestamps
  end

  @required_fields ~w(url topic private crypted_password)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
