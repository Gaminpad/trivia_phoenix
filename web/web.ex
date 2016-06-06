defmodule TriviaPhoenix.Web do
  @moduledoc """
  A module that keeps using definitions for controllers,
  views and so on.

  This can be used in your application as:

      use TriviaPhoenix.Web, :controller
      use TriviaPhoenix.Web, :view

  The definitions below will be executed for every view,
  controller, etc, so keep them short and clean, focused
  on imports, uses and aliases.

  Do NOT define functions inside the quoted expressions
  below.
  """

  def model do
    quote do
      use Ecto.Schema

      import Ecto
      import Ecto.Changeset
      import Ecto.Query, only: [from: 1, from: 2]
    end
  end

  def controller do
    quote do
      use Phoenix.Controller

      alias TriviaPhoenix.Repo
      import Ecto
      import Ecto.Query, only: [from: 1, from: 2]

      import TriviaPhoenix.Router.Helpers
      import TriviaPhoenix.Gettext

      #Importación para poder controlar que los usuarios están logueados, requisito indispensable para acceder a ciertos recuros.
      #Poniéndolo aquí nos ahorramos duplicidad de código al no tener que reescribirlo en cada controlador que queramos que actúe.
      import TriviaPhoenix.Auth, only: [authenticate_user: 2]
    end
  end

  def view do
    quote do
      use Phoenix.View, root: "web/templates"

      # Import convenience functions from controllers
      import Phoenix.Controller, only: [get_csrf_token: 0, get_flash: 2, view_module: 1]

      # Use all HTML functionality (forms, tags, etc)
      use Phoenix.HTML

      import TriviaPhoenix.Router.Helpers
      import TriviaPhoenix.ErrorHelpers
      import TriviaPhoenix.Gettext

      # Custom imports
      import TriviaPhoenix.Session, only: [current_user: 1, logged_in?: 1]
    end
  end

  def router do
    quote do
      use Phoenix.Router

      #Importación para poder controlar que los usuarios están logueados, requisito indispensable para acceder a ciertos recuros.
      #Poniéndolo aquí nos ahorramos duplicidad de código al no tener que reescribirlo en cada controlador que queramos que actúe.
      import TriviaPhoenix.Auth, only: [authenticate_user: 2]
    end
  end

  def channel do
    quote do
      use Phoenix.Channel

      alias TriviaPhoenix.Repo
      import Ecto
      import Ecto.Query, only: [from: 1, from: 2]
      import TriviaPhoenix.Gettext
    end
  end

  @doc """
  When used, dispatch to the appropriate controller/view/etc.
  """
  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
