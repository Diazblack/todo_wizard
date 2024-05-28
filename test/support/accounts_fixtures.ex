defmodule TodoWizard.AccountsFixtures do
  alias Faker.Person

  def user_fixture(attrs \\ %{}) do
    first = Person.first_name()
    last = Person.last_name()

    attrs =
      attrs
      |> Enum.into(%{
        username: "#{first}_#{last}" |> String.downcase(),
        first_name: first,
        last_name: last
      })

    {:ok, user} = TodoWizard.Accounts.register_user(attrs)
    user
  end
end
