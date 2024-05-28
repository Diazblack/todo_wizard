defmodule TodoWizardWeb.TodoItemController do
  use TodoWizardWeb, :controller

  alias TodoWizard.Data
  alias TodoWizard.Data.TodoItem

  action_fallback TodoWizardWeb.FallbackController

  def index(conn, _params) do
    todo_items = Data.list_todo_items()
    render(conn, :index, todo_items: todo_items)
  end

  def create(conn, %{"todo_item" => todo_item_params}) do
    with {:ok, %TodoItem{} = todo_item} <- Data.create_todo_item(todo_item_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/v1/todo_items/#{todo_item}")
      |> render(:show, todo_item: todo_item)
    end
  end

  def show(conn, %{"id" => id}) do
    todo_item = Data.get_todo_item!(id)
    render(conn, :show, todo_item: todo_item)
  end

  def update(conn, %{"id" => id, "todo_item" => todo_item_params}) do
    todo_item = Data.get_todo_item!(id)

    with {:ok, %TodoItem{} = todo_item} <- Data.update_todo_item(todo_item, todo_item_params) do
      render(conn, :show, todo_item: todo_item)
    end
  end

  def delete(conn, %{"id" => id}) do
    todo_item = Data.get_todo_item!(id)

    with {:ok, %TodoItem{}} <- Data.delete_todo_item(todo_item) do
      send_resp(conn, :no_content, "")
    end
  end

  def complete(conn, %{"id" => id}) do
    todo_item = Data.get_todo_item!(id)

    with {:ok, %TodoItem{} = todo_item} <- Data.complete_todo_item(todo_item) do
      render(conn, :show, todo_item: todo_item)
    end
  end
end
