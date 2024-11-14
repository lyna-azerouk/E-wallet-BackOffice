defmodule IOSAppBackOfficeWeb.PageController do
  use IOSAppBackOfficeWeb, :controller

  alias IOSAppBackOffice.User
  alias IOSAppBackOffice.Repo
  import Ecto.Query, warn: false

  def home(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    users = Repo.all(User)

    users_with_wallets = Repo.preload(users, :wallets)

    IO.inspect(users_with_wallets)
    render(conn, :home, layout: false)
  end
end
