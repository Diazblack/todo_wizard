defmodule TodoWizard.Repo do
  use Ecto.Repo,
    otp_app: :todo_wizard,
    adapter: Ecto.Adapters.Postgres
end
