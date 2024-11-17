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
end
