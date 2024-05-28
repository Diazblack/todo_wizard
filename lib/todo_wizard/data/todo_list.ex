defmodule TodoWizard.Data.TodoList do
  use TodoWizard.BaseSchema

  alias TodoWizard.Accounts.User

  schema "todo_lists" do
    field :description, :string
    field :title, :string

    belongs_to :user, User
    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(todo_list, attrs) do
    todo_list
    |> cast(attrs, [:title, :description, :user_id])
    |> validate_required([:title, :user_id])
  end
end
