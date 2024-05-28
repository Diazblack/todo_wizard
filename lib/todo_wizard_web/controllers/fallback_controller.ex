defmodule TodoWizardWeb.FallbackController do
  @moduledoc """
  Translates controller action results into valid `Plug.Conn` responses.

  See `Phoenix.Controller.action_fallback/1` for more details.
  """
  use TodoWizardWeb, :controller

  # Clause to handle resources that cannot be found.
  def call(conn, {:error, :not_found}), do: render_not_found(conn)

  # Clause to handle resources with invalid binary ids
  def call(conn, :error), do: render_not_found(conn)

  # Clause to handle Invalid Ecto Changesets
  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(html: TodoWizardWeb.ErrorHTML, json: TodoWizardWeb.ErrorJSON)
    |> render(:error, changeset: changeset)
  end

  defp render_not_found(conn) do
    conn
    |> put_status(:not_found)
    |> put_view(html: TodoWizardWeb.ErrorHTML, json: TodoWizardWeb.ErrorJSON)
    |> render(:"404")
  end
end
