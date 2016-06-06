defmodule TriviaPhoenix.RoomTest do
  use TriviaPhoenix.ModelCase

  alias TriviaPhoenix.Room

  @valid_attrs %{crypted_password: "some content", private: true, topic: "some content", url: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Room.changeset(%Room{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Room.changeset(%Room{}, @invalid_attrs)
    refute changeset.valid?
  end
end
