defmodule TodoWizard.DataFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `TodoWizard.Data` context.
  """
  alias Faker.Lorem
  alias TodoWizard.AccountsFixtures, as: AF
  alias TodoWizard.Data

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
      |> Data.create_todo_list()

    todo_list
  end

  def todo_list_fixture(attrs) do
    user = AF.user_fixture()

    attrs
    |> Enum.into(%{user_id: user.id})
    |> todo_list_fixture()
  end

  @doc """
  Generate a todo_item.
  """

  def todo_item_fixture(), do: todo_item_fixture(%{})

  def todo_item_fixture(attrs) when is_map_key(attrs, :todo_list_id) do
    {:ok, todo_item} =
      attrs
      |> Enum.into(%{
        description: Lorem.paragraph(2),
        is_checked: [true, false] |> Enum.random(),
        title: Lorem.sentence(4)
      })
      |> Data.create_todo_item()

    todo_item
  end

  def todo_item_fixture(attrs) do
    list = todo_list_fixture()

    attrs
    |> Enum.into(%{todo_list_id: list.id})
    |> todo_item_fixture()
  end
end
