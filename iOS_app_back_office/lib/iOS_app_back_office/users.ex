defmodule IOSAppBackOffice.Users do
  alias Hex.API.User
  alias IOSAppBackOffice.Repo
  alias IOSAppBackOffice.User
  alias IOSAppBackOffice.Services.Dwolla.Dwolla

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
    |> Dwolla.update_user(params)
    |> case do
      {:ok, %User{}} ->
        user
        |> User.changeset(params)
        |> Repo.update()

      {:error, _} ->
        {:error, "Error occured while updating the user"}
    end
  end

  def delete_user(%User{id: id} = user) when not is_nil(id) do
    user
    |> Repo.delete()
  end

  def update_user_state(%User{} = user, "suspended" = state) do
    user
    |> Dwolla.update_custumer_state(state)
    |> case do
      {:ok, %User{} = user} ->
        user
        |> User.changeset(%{state: state})
        |> Repo.update()

      {:error, _} = error ->
        error
    end
  end

  def update_user_state(%User{} = user, "desactivated" = state) do
    user
    |> Dwolla.update_custumer_state(state)
    |> case do
      {:ok, %User{} = user} ->
        user
        |> User.changeset(%{state: state})
        |> Repo.update()

      {:error, _} = error ->
        error
    end
  end
end
