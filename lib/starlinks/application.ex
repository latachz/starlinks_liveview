defmodule Starlinks.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Starlinks.Repo,
      # Start the Telemetry supervisor
      StarlinksWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Starlinks.PubSub},
      # Start the Endpoint (http/https)
      StarlinksWeb.Endpoint
      # Start a worker by calling: Starlinks.Worker.start_link(arg)
      # {Starlinks.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Starlinks.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    StarlinksWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
