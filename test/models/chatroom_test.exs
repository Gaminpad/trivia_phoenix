defmodule TriviaPhoenix.ChatroomTest do
  use TriviaPhoenix.ModelCase

  alias TriviaPhoenix.Chatroom

  @valid_attrs %{description: "some content", encrypt_password: "some content", private: true, topic: "some content", url: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Chatroom.changeset(%Chatroom{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Chatroom.changeset(%Chatroom{}, @invalid_attrs)
    refute changeset.valid?
  end
end
