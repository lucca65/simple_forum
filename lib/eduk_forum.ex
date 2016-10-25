defmodule SimpleForum do
  use Application

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec

    # Define workers and child supervisors to be supervised
    children = [
      # Start the Ecto repository
      supervisor(SimpleForum.Repo, []),
      # Start the endpoint when the application starts
      supervisor(SimpleForum.Endpoint, []),

      # Start your own worker by calling: SimpleForum.Worker.start_link(arg1, arg2, arg3)
      # worker(SimpleForum.Worker, [arg1, arg2, arg3]),
      # worker to schedule daily mails
      worker(SimpleForum.Scheduler, []),
    ]

    register_storage()
    load_db()

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: SimpleForum.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    SimpleForum.Endpoint.config_change(changed, removed)
    :ok
  end

  def register_storage do
    "======= Starting Storage ..." |> IO.puts
    {:ok, storage_pid} = SimpleForum.Storage.start_link
    :global.register_name(:storage, storage_pid)
  end

  def load_db do
    "======= Loading db ..." |> IO.puts
    {:ok, raw_db} = Application.get_env(:simple_forum, :file_path) |> File.read
    words = raw_db |> String.split("\n")
    pid = :global.whereis_name(:storage)

    words |> Enum.map(&(SimpleForum.Storage.put(pid, &1)))
  end
end
