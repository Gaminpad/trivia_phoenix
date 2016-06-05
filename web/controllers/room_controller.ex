defmodule TriviaPhoenix.RoomController do

  use TriviaPhoenix.Web, :controller
  alias TriviaPhoenix.Room
  import TriviaPhoenix.Session, only: [current_user: 1, logged_in?: 1]

  plug :scrub_params, "room" when action in [:create, :update]

  def new(conn, _params) do
    changeset = Room.changeset(%Room{})
    render conn, changeset: changeset
  end

  def create(conn, %{"room" => room_params}) do
    if logged_in?(@conn) do
      changeset = Room.changeset(%Room{}, room_params)
      case TriviaPhoenix.Room.create(changeset, current_user(@conn)) do
        {:ok, changeset} ->
          conn
          |> put_flash(:info, "Your room was created")
          |> redirect(to: room_path(conn, :new))
        {:error, changeset} ->
          IO.puts("DEBUG :: RoomController.create")
          IO.inspect(changeset)
          conn
          |> put_flash(:info, "Unable to create Room")
          |> render("new.html", changeset: changeset)
      end
    else
      conn
      |> put_flash(:info, "You must be logged in to create a Room")
      |> redirect(to: session_path(conn, :new))
    end
  end

end
