defmodule TodoWizard.DataFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `TodoWizard.Data` context.
  """
  alias Faker.Lorem
  alias TodoWizard.AccountsFixtures, as: AF

  @doc """
  Generate a todo_list.
  """

  def todo_list_fixture(), do: todo_list_fixture(%{})

  def todo_list_fixture(attrs) when is_map_key(attrs, :user_id) do
    {:ok, todo_list} =
      attrs
      |> Enum.into(%{
        description: Lorem.paragraph(2),
        title: Lorem.sentence(4)
      })
      |> TodoWizard.Data.create_todo_list()

    todo_list
  end

  def todo_list_fixture(attrs) do
    user = AF.user_fixture()

    todo_list =
      attrs
      |> Enum.into(%{user_id: user.id})
      |> todo_list_fixture()

    todo_list
  end
end
