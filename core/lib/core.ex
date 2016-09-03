defmodule Core do
  use Application

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    # import Supervisor.Spec, warn: false

    # # Define workers and child supervisors to be supervised
    # children = [
    #   # Starts a worker by calling: Core.Worker.start_link(arg1, arg2, arg3)
    #   # worker(Core.Worker, [arg1, arg2, arg3]),
    #   # worker(Connection.RethinkDB, [])
    # ]

    # # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # # for other strategies and supported options
    # opts = [strategy: :one_for_one, name: Core.Supervisor]
    # Supervisor.start_link(children, opts)
    Core.Supervisor.start_link
  end

  def hello do
    # RethinkDB.Connection.start_link([host: "10.0.0.17", port: 28015])
    %{hello: "world"}
  end
end
