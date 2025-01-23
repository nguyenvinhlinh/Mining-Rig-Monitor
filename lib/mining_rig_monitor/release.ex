defmodule MiningRigMonitor.Release do
  require Logger
  alias MiningRigMonitor.Accounts
  @moduledoc """
  Used for executing DB release tasks when run in production without Mix
  installed.
  """

  @app :mining_rig_monitor

  def migrate do
    load_app()

    for repo <- repos() do
      {:ok, _, _} = Ecto.Migrator.with_repo(repo, &Ecto.Migrator.run(&1, :up, all: true))
    end
  end

  def rollback(repo, version) do
    load_app()
    {:ok, _, _} = Ecto.Migrator.with_repo(repo, &Ecto.Migrator.run(&1, :down, to: version))
  end

  defp repos do
    Application.fetch_env!(@app, :ecto_repos)
  end

  defp load_app do
    Application.load(@app)
  end

  def create_account(args) do
    load_app()
    Application.ensure_all_started(@app)
    args_list = String.split(args, " ")
    parser_option = [strict: [email: :string]]
    {parsed, _args, _invalid} = OptionParser.parse(args_list, parser_option)

    with email <- Keyword.get(parsed, :email),
         {:ok} <- check_nil_email(email),
           password <- generate_random_password(),
         {:ok, _user} <- Accounts.register_user(%{email: email, password: password}) do

      Logger.info "[Mining Rig Monitor] Created a new account successfully!"
      Logger.info "[Mining Rig Monitor] Email: #{email}"
      Logger.info "[Mining Rig Monitor] Password: #{password}"
    else
      {:error, :nil_email} -> Logger.info "[Mining Rig Monitor] empty email address"
    {:error, %Ecto.Changeset{}=changeset} ->
        Logger.error "[Mining Rig Monitor] cannot create a new account. Check `changeset.errors`"
        IO.inspect changeset.errors
    end
  end

  def reset_account_password(args) do
    load_app()
    Application.ensure_all_started(@app)
    args_list = String.split(args, " ")
    parser_option = [strict: [email: :string]]
    {parsed, _args, _invalid} = OptionParser.parse(args_list, parser_option)

    with email <- Keyword.get(parsed, :email),
         {:ok} <- check_nil_email(email),
           {:ok, user} <- get_user(email),
           password <- generate_random_password(),
         {:ok, _user} <- Accounts.force_update_user_password(user, %{password: password}) do

      Logger.info "[Mining Rig Monitor] Reset account password successfully!"
      Logger.info "[Mining Rig Monitor] Email: #{email}"
      Logger.info "[Mining Rig Monitor] Password: #{password}"
    else
      {:error, :nil_email} -> Logger.error "[Mining Rig Monitor] empty email address"
      {:error, :user_not_found, email} -> Logger.error "[Mining Rig Monitor] Invalid user email: #{email}"
      {:error, %Ecto.Changeset{}=changeset} ->
        Logger.error "[Mining Rig Monitor] cannot reset password. Check `changeset.errors`"
        IO.inspect changeset.errors
    end
  end

  def check_nil_email(nil), do: {:error, :nil_email}
  def check_nil_email(""), do: {:error, :nil_email}
  def check_nil_email(_), do: {:ok}

  def generate_random_password() do
    password_char_list = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "0",
                          "A", "B", "C", "D", "E", "F"]

    for _i <- 1..64 do
      Enum.random(password_char_list)
    end
    |> Enum.join()
  end

  def get_user(email) do
    user = Accounts.get_user_by_email(email)
    if Kernel.is_nil(user) == false, do: {:ok, user}, else: {:error, :user_not_found, email}
  end
end
