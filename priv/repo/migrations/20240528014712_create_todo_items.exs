defmodule TodoWizard.Repo.Migrations.CreateTodoItems do
  use Ecto.Migration

  def change do
    create table(:todo_items, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :title, :string
      add :description, :text
      add :is_checked, :boolean, default: false, null: false
      add :todo_list_id, references(:todo_lists, on_delete: :nothing, type: :binary_id)

      timestamps(type: :utc_datetime_usec)
    end

    create index(:todo_items, [:todo_list_id])
  end
end
