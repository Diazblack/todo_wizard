defmodule TodoWizard.Acounts do
  alias TodoWizard.Accounts.User
  alias TodoWizard.Repo

  @doc """
  Registers a user.

  ## Examples

      iex> register_user(%{username: "elwe_v_esse"})
      {:ok, %User{}}

      iex> register_user(%{username: nil})
      {:error, %Ecto.Changeset{}}

  """
  def register_user(attrs) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Gets a single by username

  returns

  ## Examples

      iex> get_by_username("elwe_v_esse")
      %User{}

      iex> get_by_username("i_dont_exists")
      ** (Ecto.NoResultsError)

  """
  def get_by_username(username), do: Repo.get_by(User, username: username)

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user(uuid)
      {:ok, %User{}}

      iex> get_user(123)
      {:error, :not_found}

  """
  def get_user(id), do: Repo.fetch(User, id)

  @doc """
    Update user information

      ## Examples

      iex> get_user(%User{}, %{last_name: "Pedro"})
      {:ok, %User{}}

      iex> get_user(user, %{})
      {:error, %Ecto.Changeset{}}
  """
  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
    deletes the user account
  """
  def delete(%User{} = user) do
    Repo.delete(user)
  end
end
