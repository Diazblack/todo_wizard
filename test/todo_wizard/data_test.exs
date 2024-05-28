defmodule TodoWizard.DataTest do
  use TodoWizard.DataCase

  alias TodoWizard.Data

  describe "todo_lists" do
    alias TodoWizard.Data.TodoList

    import TodoWizard.DataFixtures
    import TodoWizard.AccountsFixtures

    @invalid_attrs %{description: nil, title: nil}

    test "get_todo_list/1 returns the todo_list with given id" do
      todo_list = todo_list_fixture()
      {:ok, list} = Data.get_todo_list(todo_list.id)
      assert list.id == todo_list.id
    end

    test "create_todo_list/1 with valid data creates a todo_list" do
      %{id: user_id} = user_fixture()
      valid_attrs = %{description: "some description", title: "some title", user_id: user_id}

      assert {:ok, %TodoList{} = todo_list} = Data.create_todo_list(valid_attrs)
      assert todo_list.description == "some description"
      assert todo_list.title == "some title"
      assert todo_list.user_id == user_id
    end

    test "create_todo_list/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Data.create_todo_list(@invalid_attrs)
    end

    test "update_todo_list/2 with valid data updates the todo_list" do
      todo_list = todo_list_fixture()
      update_attrs = %{description: "some updated description", title: "some updated title"}

      assert {:ok, %TodoList{} = todo_list} = Data.update_todo_list(todo_list, update_attrs)
      assert todo_list.description == "some updated description"
      assert todo_list.title == "some updated title"
    end

    test "update_todo_list/2 with invalid data returns error changeset" do
      todo_list = todo_list_fixture()
      assert {:error, %Ecto.Changeset{}} = Data.update_todo_list(todo_list, @invalid_attrs)
      {:ok, list} = Data.get_todo_list(todo_list.id)
      assert todo_list.description == list.description
      assert todo_list.title == list.title
      assert todo_list.user_id == list.user_id
    end

    test "delete_todo_list/1 deletes the todo_list" do
      todo_list = todo_list_fixture()
      assert {:ok, %TodoList{}} = Data.delete_todo_list(todo_list)
      assert {:error, :not_found} = Data.get_todo_list(todo_list.id)
    end

    test "change_todo_list/1 returns a todo_list changeset" do
      todo_list = todo_list_fixture()
      assert %Ecto.Changeset{} = Data.change_todo_list(todo_list)
    end
  end

  describe "todo_items" do
    alias TodoWizard.Data.TodoItem

    import TodoWizard.DataFixtures

    @invalid_attrs %{description: nil, title: nil, is_checked: nil}

    test "list_todo_items/0 returns all todo_items" do
      todo_item = todo_item_fixture()
      assert Data.list_todo_items() == [todo_item]
    end

    test "get_todo_item!/1 returns the todo_item with given id" do
      todo_item = todo_item_fixture()
      assert Data.get_todo_item!(todo_item.id) == todo_item
    end

    test "create_todo_item/1 with valid data creates a todo_item" do
      list = todo_list_fixture()

      valid_attrs = %{
        description: "some description",
        title: "some title",
        is_checked: true,
        todo_list_id: list.id
      }

      assert {:ok, %TodoItem{} = todo_item} = Data.create_todo_item(valid_attrs)
      assert todo_item.description == "some description"
      assert todo_item.title == "some title"
      assert todo_item.is_checked == true
    end

    test "create_todo_item/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Data.create_todo_item(@invalid_attrs)
    end

    test "update_todo_item/2 with valid data updates the todo_item" do
      todo_item = todo_item_fixture()

      update_attrs = %{
        description: "some updated description",
        title: "some updated title",
        is_checked: false
      }

      assert {:ok, %TodoItem{} = todo_item} = Data.update_todo_item(todo_item, update_attrs)
      assert todo_item.description == "some updated description"
      assert todo_item.title == "some updated title"
      assert todo_item.is_checked == false
    end

    test "update_todo_item/2 with invalid data returns error changeset" do
      todo_item = todo_item_fixture()
      assert {:error, %Ecto.Changeset{}} = Data.update_todo_item(todo_item, @invalid_attrs)
      assert todo_item == Data.get_todo_item!(todo_item.id)
    end

    test "delete_todo_item/1 deletes the todo_item" do
      todo_item = todo_item_fixture()
      assert {:ok, %TodoItem{}} = Data.delete_todo_item(todo_item)
      assert_raise Ecto.NoResultsError, fn -> Data.get_todo_item!(todo_item.id) end
    end

    test "change_todo_item/1 returns a todo_item changeset" do
      todo_item = todo_item_fixture()
      assert %Ecto.Changeset{} = Data.change_todo_item(todo_item)
    end
  end
end
