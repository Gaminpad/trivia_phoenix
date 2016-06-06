defmodule TriviaPhoenix.Room do
  use TriviaPhoenix.Web, :model

  schema "chatrooms" do
    field :url, :string
    field :topic, :string
    field :private, :boolean, default: false
    field :encrypt_password, :string
    field :description, :string
    belongs_to :user, TriviaPhoenix.User

    timestamps
  end

  @required_fields ~w(url topic private description)
  @optional_fields ~w(encrypt_password)

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> unique_constraint(:url)
  end

  defp hashed_password(password) do
    hashed_pass = Comeonin.Bcrypt.hashpwsalt(password)
    IO.puts("hashed_pass: #{hashed_pass}")
    hashed_pass
  end
end
