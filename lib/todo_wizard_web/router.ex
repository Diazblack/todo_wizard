defmodule TodoWizardWeb.Router do
  use TodoWizardWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {TodoWizardWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  # Other scopes may use custom stacks.
  scope "/api/v1", TodoWizardWeb do
    pipe_through :api

    post "/users/", UserController, :create
    get "/users/:username", UserController, :show
    put "/users/:username", UserController, :update
    delete "/users/:username", UserController, :delete

    resources "/todo_lists", TodoListController, except: [:new, :edit]

    resources "/todo_items", TodoItemController, except: [:new, :edit, :index]
    put "/todo_items/done/:id", TodoItemController, :complete
  end

  # Enable Swoosh mailbox preview in development
  if Application.compile_env(:todo_wizard, :dev_routes) do
    scope "/dev" do
      pipe_through :browser

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
