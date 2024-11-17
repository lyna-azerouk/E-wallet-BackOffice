defmodule IOSAppBackOfficeWeb.AdminController do
  use IOSAppBackOfficeWeb, :controller

  alias IOSAppBackOffice.Accounts
  alias IOSAppBackOfficeWeb.Router, as: Routes

  def show(conn, _params) do
    render(conn, :login, layout: false)
  end

  def login(conn, %{"email"=> email, "password"=> password} = params) do

    case Accounts.compare_credentials(params) do
      {:ok, admin} -> conn
        |> put_session(:admin, admin)
        |> redirect( to: "/admin/profile")

      {:error, _} -> conn
                    |> put_flash(:error, "Error while login")
                    |> render(:login)
    end
  end
end
