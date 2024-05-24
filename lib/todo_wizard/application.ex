defmodule TodoWizard.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      TodoWizardWeb.Telemetry,
      TodoWizard.Repo,
      {DNSCluster, query: Application.get_env(:todo_wizard, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: TodoWizard.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: TodoWizard.Finch},
      # Start a worker by calling: TodoWizard.Worker.start_link(arg)
      # {TodoWizard.Worker, arg},
      # Start to serve requests, typically the last entry
      TodoWizardWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: TodoWizard.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    TodoWizardWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
