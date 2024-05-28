defmodule TodoWizardWeb.TodoListJSON do
  alias TodoWizard.Data.TodoList

  @doc """
  Renders a list of todo_lists.
  """
  def index(%{todo_lists: todo_lists}) do
    %{data: for(todo_list <- todo_lists, do: data(todo_list))}
  end

  @doc """
  Renders a single todo_list.
  """
  def show(%{todo_list: todo_list}) do
    %{data: data(todo_list)}
  end

  defp data(%TodoList{} = todo_list) do
    todo_list
    |> Map.take(~w[id title description user_id]a)
  end
end
