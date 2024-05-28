defmodule TodoWizardWeb.TodoItemControllerTest do
  use TodoWizardWeb.ConnCase

  import TodoWizard.DataFixtures

  alias TodoWizard.Data.TodoItem

  @create_attrs %{
    description: "some description",
    title: "some title",
    is_checked: true,
    todo_list_id: ""
  }
  @update_attrs %{
    description: "some updated description",
    title: "some updated title",
    is_checked: false
  }
  @invalid_attrs %{description: nil, title: nil, is_checked: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "create todo_item ->" do
    test "renders todo_item when data is valid", %{conn: conn} do
      list = todo_list_fixture()

      conn =
        post(conn, ~p"/api/v1/todo_items", todo_item: %{@create_attrs | todo_list_id: list.id})

      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/v1/todo_items/#{id}")

      assert %{
               "id" => ^id,
               "description" => "some description",
               "is_checked" => true,
               "title" => "some title"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/v1/todo_items", todo_item: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update todo_item ->" do
    setup [:create_todo_item]

    test "renders todo_item when data is valid", %{
      conn: conn,
      todo_item: %TodoItem{id: id} = todo_item
    } do
      conn = put(conn, ~p"/api/v1/todo_items/#{todo_item}", todo_item: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/v1/todo_items/#{id}")

      assert %{
               "id" => ^id,
               "description" => "some updated description",
               "is_checked" => false,
               "title" => "some updated title"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, todo_item: todo_item} do
      conn = put(conn, ~p"/api/v1/todo_items/#{todo_item}", todo_item: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete todo_item ->" do
    setup [:create_todo_item]

    test "deletes chosen todo_item", %{conn: conn, todo_item: todo_item} do
      conn = delete(conn, ~p"/api/v1/todo_items/#{todo_item}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/v1/todo_items/#{todo_item}")
      end
    end
  end

  describe "checked todo_item ->" do
    test "set the is_checked field on the todo_item", %{conn: conn} do
      todo_item = todo_item_fixture(%{is_checked: false})

      %{"data" => resp} =
        conn
        |> put(~p"/api/v1/todo_items/done/#{todo_item}", %{})
        |> json_response(200)

      assert resp["is_checked"]
    end
  end

  defp create_todo_item(_) do
    todo_item = todo_item_fixture()
    %{todo_item: todo_item}
  end
end
