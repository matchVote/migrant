defmodule Migrant.ReleaseTasks do
  @start_apps [
    :crypto,
    :ssl,
    :postgrex,
    :ecto,
    :ecto_sql
  ]

  @repos Application.get_env(:migrant, :ecto_repos)

  @spec migrate(any()) :: any()
  def migrate(_argv) do
    start_services()
    run_migrations()
    stop_services()
  end

  defp start_services do
    IO.puts("Starting dependent apps...")
    Enum.each(@start_apps, &Application.ensure_all_started/1)

    IO.puts("Starting repos...")
    Enum.each(@repos, & &1.start_link(pool_size: 2))
  end

  defp run_migrations do
    Enum.each(@repos, fn repo ->
      app = Keyword.get(repo.config, :otp_app)
      IO.puts("Running migrations for #{app}")
      migrations_path = priv_path_for(repo, "migrations", app)
      Ecto.Migrator.run(repo, migrations_path, :up, all: true)
    end)
  end

  defp stop_services do
    IO.puts("Success!")
    :init.stop()
  end

  defp priv_path_for(repo, filename, app) do
    repo_underscore =
      repo
      |> Module.split()
      |> List.last()
      |> Macro.underscore()

    priv_dir = "#{:code.priv_dir(app)}"
    Path.join([priv_dir, repo_underscore, filename])
  end
end
