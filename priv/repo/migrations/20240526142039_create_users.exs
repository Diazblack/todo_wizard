defmodule TodoWizard.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :first_name, :string
      add :last_name, :string
      add :username, :string

      timestamps(type: :utc_datetime_usec)
    end

    create unique_index(:users, [:username])
  end
end
