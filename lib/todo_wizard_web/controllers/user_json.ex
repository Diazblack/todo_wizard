defmodule TodoWizardWeb.UserJSON do
  alias TodoWizard.Accounts.User

  @doc """
  Renders a list of users.
  """
  def index(%{users: users}) do
    %{data: for(user <- users, do: data(user))}
  end

  @doc """
  Renders a single user.
  """
  def show(%{user: user}) do
    %{data: data(user)}
  end

  defp data(%User{} = user) do
    user
    |> Map.take(~w[id first_name last_name username]a)
  end
end
