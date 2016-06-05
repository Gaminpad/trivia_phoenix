defmodule TriviaPhoenix.ChatroomController do
  use TriviaPhoenix.Web, :controller
  alias TriviaPhoenix.Chatroom

  plug :scrub_params, "chatroom" when action in [:create, :update]
  plug :authenticate_user

  def index(conn, _params, user) do
    chatrooms = Repo.all(Chatroom)
    render(conn, "index.html", chatrooms: chatrooms)
  end

  def new(conn, _params, user) do
    changeset =
      user
      |> build_assoc(:chatrooms)
      |> Chatroom.changeset()
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"chatroom" => chatroom_params}, user) do
    changeset =
      user
      |> build_assoc(:chatrooms)
      |> Chatroom.changeset(chatroom_params)

    case Repo.insert(changeset) do
      {:ok, _chatroom} ->
        conn
        |> put_flash(:info, "Chatroom created successfully.")
        |> redirect(to: chatroom_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}, user) do
    chatroom = Repo.get!(Chatroom, id)
    render(conn, "show.html", chatroom: chatroom)
  end

  def edit(conn, %{"id" => id}, user) do
    chatroom = Repo.get!(Chatroom, id)
    changeset = Chatroom.changeset(chatroom)
    render(conn, "edit.html", chatroom: chatroom, changeset: changeset)
  end

  def update(conn, %{"id" => id, "chatroom" => chatroom_params}, user) do
    chatroom = Repo.get!(Chatroom, id)
    changeset = Chatroom.changeset(chatroom, chatroom_params)

    case Repo.update(changeset) do
      {:ok, chatroom} ->
        conn
        |> put_flash(:info, "Chatroom updated successfully.")
        |> redirect(to: chatroom_path(conn, :show, chatroom))
      {:error, changeset} ->
        render(conn, "edit.html", chatroom: chatroom, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    chatroom = Repo.get!(Chatroom, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(chatroom)

    conn
    |> put_flash(:info, "Chatroom deleted successfully.")
    |> redirect(to: chatroom_path(conn, :index))
  end

  #Sobreescribe la función action por defecto de todos los controladores,
  #para poder enviar como tercer parámetro de las funciones del módulo el usuario
  #de la session
  def action(conn, _) do
    apply(__MODULE__, action_name(conn),
      [conn, conn.params, conn.assigns.current_user])
  end
end
