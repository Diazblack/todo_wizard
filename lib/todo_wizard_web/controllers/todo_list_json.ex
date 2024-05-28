defmodule TodoWizardWeb.TodoListJSON do
  alias TodoWizard.Data.TodoList
  alias TodoWizardWeb.TodoItemJSON

  @doc """
  Renders a list of todo_lists.
  """
  def index(%{todo_lists: todo_lists}) do
    %{data: for(todo_list <- todo_lists, do: data(todo_list))}
  end

  @doc """
  Renders a single todo_list.
  """
  def show(%{todo_list: %{todo_items: ti} = todo_list})
      when not is_struct(ti, Ecto.Association.NotLoaded) do
    %{data: todo_items} = TodoItemJSON.index(%{todo_items: ti})

    todo_list = todo_list |> data() |> Map.put(:todo_items, todo_items)

    %{data: todo_list}
  end

  def show(%{todo_list: todo_list}) do
    %{data: data(todo_list)}
  end

  defp data(%TodoList{} = todo_list) do
    todo_list
    |> Map.take(~w[id title description user_id]a)
  end
end
