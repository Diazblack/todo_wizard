defmodule TodoWizard.Data.TodoList do
  use TodoWizard.BaseSchema

  alias TodoWizard.Accounts.User
  alias TodoWizard.Data.TodoItem

  schema "todo_lists" do
    field :description, :string
    field :title, :string

    belongs_to :user, User
    has_many :todo_items, TodoItem
    timestamps()
  end

  @doc false
  def changeset(todo_list, attrs) do
    todo_list
    |> cast(attrs, [:title, :description, :user_id])
    |> validate_required([:title, :user_id])
    |> foreign_key_constraint(:user_id)
  end
end
