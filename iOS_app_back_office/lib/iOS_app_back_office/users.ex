defmodule IOSAppBackOffice.Users do
  alias Hex.API.User
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

  def get_user(_), do: nil

  def update_user(%User{id: id} = user, params) when not is_nil(id) do
    user
    |> User.changeset(params)
    |> Repo.update()
  end

  def delete_user(%User{id: id} = user) when not is_nil(id) do
    user
    |> Repo.delete()
  end

  def update_user_state(%User{} = user, "suspended") do
    user
    |> User.changeset(%{state: "suspended"})
    |> Repo.update()
  end

  def update_user_state(%User{} = user, "deactivated") do
    user
    |> User.changeset(%{state: "deactivated"})
    |> Repo.update()
  end

  def update_user_state(%User{} = user, "verified") do
    user
    |> User.changeset(%{state: "verified"})
    |> Repo.update()
  end
end
