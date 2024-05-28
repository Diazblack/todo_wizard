defmodule TodoWizardWeb.TodoListController do
  use TodoWizardWeb, :controller

  alias TodoWizard.Data
  alias TodoWizard.Data.TodoList

  action_fallback TodoWizardWeb.FallbackController

  def create(conn, %{"todo_list" => todo_list_params}) do
    with {:ok, %TodoList{} = todo_list} <- Data.create_todo_list(todo_list_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/v1/todo_lists/#{todo_list}")
      |> render(:show, todo_list: todo_list)
    end
  end

  def show(conn, %{"id" => id}) do
    with {:ok, todo_list} <- Data.get_todo_list(id) do
      render(conn, :show, todo_list: todo_list)
    end
  end

  def update(conn, %{"id" => id, "todo_list" => todo_list_params}) do
    with {:ok, todo_list} <- Data.get_todo_list(id),
         {:ok, %TodoList{} = todo_list} <- Data.update_todo_list(todo_list, todo_list_params) do
      render(conn, :show, todo_list: todo_list)
    end
  end

  def delete(conn, %{"id" => id}) do
    with {:ok, todo_list} <- Data.get_todo_list(id),
         {:ok, %TodoList{}} <- Data.delete_todo_list(todo_list) do
      send_resp(conn, :no_content, "")
    end
  end

  # def complete()
end
