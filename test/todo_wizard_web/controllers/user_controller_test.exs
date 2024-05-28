defmodule TodoWizardWeb.UserControllerTest do
  use TodoWizardWeb.ConnCase

  import TodoWizard.AccountsFixtures

  alias TodoWizard.Accounts
  alias TodoWizard.Accounts.User

  @create_attrs %{
    username: "some username",
    first_name: "some first_name",
    last_name: "some last_name"
  }
  @update_attrs %{
    username: "update_username",
    first_name: "some updated first_name",
    last_name: "some updated last_name"
  }
  @invalid_attrs %{username: nil, first_name: nil, last_name: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "create user ->" do
    test "renders user when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/v1/users", user: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      {:ok, user} = Accounts.get_by_username("some username")
      assert id == user.id
      assert @create_attrs.first_name == user.first_name
      assert @create_attrs.last_name == user.last_name
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/v1/users", user: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update user ->" do
    setup [:create_user]

    test "renders user when data is valid", %{
      conn: conn,
      user: %User{username: username, id: id} = user
    } do
      conn = put(conn, ~p"/api/v1/users/#{username}", user: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      {:ok, user} = Accounts.get_by_username(@update_attrs.username)
      assert @update_attrs.first_name == user.first_name
      assert @update_attrs.last_name == user.last_name
    end

    test "renders errors when data is invalid", %{conn: conn, user: user} do
      conn = put(conn, ~p"/api/v1/users/#{user.username}", user: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete user ->" do
    setup [:create_user]

    test "deletes chosen user", %{conn: conn, user: user} do
      conn = delete(conn, ~p"/api/v1/users/#{user.username}")
      assert response(conn, 204)

      conn = get(conn, ~p"/api/v1/users/#{user.username}")
      assert response(conn, 404)
    end
  end

  defp create_user(_) do
    user = user_fixture()
    %{user: user}
  end
end
