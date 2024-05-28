defmodule TodoWizard.Accounts.User do
  use TodoWizard.BaseSchema

  alias TodoWizard.Data.TodoList

  schema "users" do
    field :username, :string
    field :first_name, :string
    field :last_name, :string

    has_many :todo_lists, TodoList
    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:first_name, :last_name, :username])
    |> validate_required([:username])
    |> unique_constraint(:username)
  end
end
