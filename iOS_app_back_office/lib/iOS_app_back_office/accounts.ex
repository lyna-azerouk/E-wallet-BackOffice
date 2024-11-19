defmodule IOSAppBackOffice.Accounts do
  alias IOSAppBackOffice.Admin
  alias IOSAppBackOffice.Repo

  def compare_credentials(%{"email" => email, "password" => password}) do
    get_admin_by_email(email)
    |> case do
      %Admin{} = admin ->
        admin
        |> compare_password(password)
        |> case do
          true -> {:ok, admin}
          _ -> {:error, :admin_not_found}
        end

      _ ->
        {:error, :admin_not_found}
    end
  end

  def compare_credentials(_), do: {:error, :admin_not_found}

  defp get_admin_by_email(email) do
    Repo.get_by(Admin, email: email)
  end

  defp compare_password(%Admin{password: hashed_password}, password) do
    Bcrypt.verify_pass(password, hashed_password)
  end

  defp compare_password(_, _password), do: {:error, :admin_not_found}
end
