defmodule Mix.Tasks.Mrm.ResetAccountPassword do
  @shortdoc "Reset a mining rig monitor account password"
  @moduledoc """
  Create a mining rig monitor account

    $ mix mrm.reset_account --email=my_email@gmail.com

  Required Parameters:
  - email

  Password will be output in the terminal.
  """
  use Mix.Task
  require Logger
  alias MiningRigMonitor.Accounts


  @requirements ["app.start"]
  def run(args) do
    parser_option = [strict: [email: :string]]
    {parsed, _args, _invalid} = OptionParser.parse(args, parser_option)

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

  def get_user(email) do
    user = Accounts.get_user_by_email(email)
    if Kernel.is_nil(user) == false, do: {:ok, user}, else: {:error, :user_not_found, email}
  end

  def generate_random_password() do
    password_char_list = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "0",
                          "A", "B", "C", "D", "E", "F"]

    for _i <- 1..64 do
      Enum.random(password_char_list)
    end
    |> Enum.join()
  end
end
