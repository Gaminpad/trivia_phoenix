defmodule TriviaPhoenix.RoomController do
  use TriviaPhoenix.Web, :controller

  alias TriviaPhoenix.Room

  plug :scrub_params, "chatroom" when action in [:create, :update]

  def index(conn, _params) do
    chatrooms = Repo.all(Room)
    render(conn, "index.html", chatrooms: chatrooms)
  end

  def new(conn, _params) do
    changeset = Room.changeset(%Room{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"chatroom" => chatroom_params}) do
    changeset = Room.changeset(%Room{}, chatroom_params)

    case Repo.insert(changeset) do
      {:ok, _chatroom} ->
        conn
        |> put_flash(:info, "Room created successfully.")
        |> redirect(to: chatroom_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    chatroom = Repo.get!(Room, id)
    render(conn, "show.html", chatroom: chatroom)
  end

  def edit(conn, %{"id" => id}) do
    chatroom = Repo.get!(Room, id)
    changeset = Room.changeset(chatroom)
    render(conn, "edit.html", chatroom: chatroom, changeset: changeset)
  end

  def update(conn, %{"id" => id, "chatroom" => chatroom_params}) do
    chatroom = Repo.get!(Room, id)
    changeset = Room.changeset(chatroom, chatroom_params)

    case Repo.update(changeset) do
      {:ok, chatroom} ->
        conn
        |> put_flash(:info, "Room updated successfully.")
        |> redirect(to: chatroom_path(conn, :show, chatroom))
      {:error, changeset} ->
        render(conn, "edit.html", chatroom: chatroom, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    chatroom = Repo.get!(Room, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(chatroom)

    conn
    |> put_flash(:info, "Room deleted successfully.")
    |> redirect(to: chatroom_path(conn, :index))
  end
end
