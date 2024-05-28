defmodule TodoWizardWeb.TodoItemJSON do
  alias TodoWizard.Data.TodoItem

  @doc """
  Renders a list of todo_items.
  """
  def index(%{todo_items: todo_items}) do
    %{data: for(todo_item <- todo_items, do: data(todo_item))}
  end

  @doc """
  Renders a single todo_item.
  """
  def show(%{todo_item: todo_item}) do
    %{data: data(todo_item)}
  end

  defp data(%TodoItem{} = todo_item) do
    todo_item
    |> Map.take(~w[id title description is_checked todo_list_id]a)
  end
end
