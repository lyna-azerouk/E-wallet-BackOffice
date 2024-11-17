defmodule IOSAppBackOffice.Users do

  alias IOSAppBackOffice.Repo
  alias IOSAppBackOffice.User

  def get_users() do
    User |> Repo.all()
  end

  def paginate_users(params \\ []) do
    User
    |> Repo.paginate(params)
  end

  def get_user(id) when is_binary(id) do
    User
    |> Repo.get_by(id: String.to_integer(id))
    |> Repo.preload(:wallets)
    |> Repo.preload(:address)
  end

  def get(_), do: nil
end
