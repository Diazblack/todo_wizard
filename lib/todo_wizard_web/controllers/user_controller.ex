defmodule TodoWizardWeb.UserController do
  use TodoWizardWeb, :controller

  alias TodoWizard.Accounts
  alias TodoWizard.Accounts.User

  action_fallback TodoWizardWeb.FallbackController

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Accounts.register_user(user_params) do
      conn
      |> put_status(:created)
      |> render(:show, user: user)
    end
  end

  def show(conn, %{"username" => username}) do
    with {:ok, user} <- Accounts.get_by_username(username) do
      render(conn, :show, user: user)
    end
  end

  def update(conn, %{"username" => username, "user" => user_params}) do
    with {:ok, user} <- Accounts.get_by_username(username),
         {:ok, %User{} = user} <- Accounts.update_user(user, user_params) do
      render(conn, :show, user: user)
    end
  end

  def delete(conn, %{"username" => username}) do
    with {:ok, user} <- Accounts.get_by_username(username),
         {:ok, %User{}} <- Accounts.delete(user) do
      send_resp(conn, :no_content, "")
    end
  end
end
