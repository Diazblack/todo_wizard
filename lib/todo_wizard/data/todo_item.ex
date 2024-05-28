defmodule TodoWizard.Data.TodoItem do
  use TodoWizard.BaseSchema

  alias TodoWizard.Data.TodoList

  schema "todo_items" do
    field :description, :string
    field :title, :string
    field :is_checked, :boolean, default: false

    belongs_to :todo_list, TodoList

    timestamps()
  end

  @doc false
  def changeset(todo_item, attrs) do
    todo_item
    |> cast(attrs, [:title, :description, :is_checked, :todo_list_id])
    |> validate_required([:description, :is_checked, :todo_list_id])
    |> foreign_key_constraint(:todo_list_id)
  end
end
