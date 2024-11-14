defmodule IOSAppBackOfficeWeb.AdminController do
  use IOSAppBackOfficeWeb, :controller

  def login(conn, _params) do

    render(conn, :login, layout: false)
  end
end
