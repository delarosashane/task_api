defmodule TaskApiWeb.UserController do
  use TaskApiWeb, :controller

  alias TaskApi.Accounts
  alias TaskApi.Accounts.User
  alias TaskApiWeb.Auth.Guardian

  action_fallback TaskApiWeb.FallbackController

  # def index(conn, _params) do
  #   users = Accounts.list_users()
  #   render(conn, "index.json", users: users)
  # end

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Accounts.create_user(user_params),
    {:ok, token, _claims} <- Guardian.encode_and_sign(user) do
      conn
      |> put_status(:created)
      |> render("user.json", %{user: user, token: token})
    end
  end

  def login(conn, %{"username" => username, "password" => password}) do
    with {:ok, user, token} <- Guardian.authenticate(username, password) do
      conn
      |> put_status(:created)
      |> render("user.json", %{user: user, token: token})
    end
  end

  # def show(conn, %{"id" => id}) do
  #   user = Accounts.get_user!(id)
  #   render(conn, "show.json", user: user)
  # end

  # def update(conn, %{"id" => id, "user" => user_params}) do
  #   user = Accounts.get_user!(id)

  #   with {:ok, %User{} = user} <- Accounts.update_user(user, user_params) do
  #     render(conn, "show.json", user: user)
  #   end
  # end

  # def delete(conn, %{"id" => id}) do
  #   user = Accounts.get_user!(id)

  #   with {:ok, %User{}} <- Accounts.delete_user(user) do
  #     send_resp(conn, :no_content, "")
  #   end
  # end
end
