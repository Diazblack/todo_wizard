defmodule TodoWizard.Repo do
  use Ecto.Repo,
    otp_app: :todo_wizard,
    adapter: Ecto.Adapters.Postgres

  alias Ecto.UUID

  def fetch(type, id) do
    with {:ok, uuid} <- UUID.cast(id),
         result when not is_nil(result) <- get(type, uuid) do
      {:ok, result}
    else
      _any -> {:error, :not_found}
    end
  end
end
