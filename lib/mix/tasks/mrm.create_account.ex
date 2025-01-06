defmodule Mix.Tasks.Mrm.CreateAccount do
  @shortdoc "Create new mining rig monitor account"
  @moduledoc """
  Create a mining rig monitor account

    $ mix mrm.create_account --email=my_email@gmail.com

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
end
