defmodule IOSAppBackOfficeWeb.Plugs.Auth do
  import Plug.Conn
  import Phoenix.Controller

  alias IOSAppBackOffice.Admin

  def init(default), do: default

  def call(%Plug.Conn{} = conn, _opt) do
    verify_access!(conn)
  end

  defp verify_access!(%Plug.Conn{ request_path: _path} = conn) do
    get_session(conn, :admin)
      |> case do
        %Admin{} -> conn
        _ ->   conn
        |> put_flash(:error, "Unauthorized")
        |> redirect(to:  "/admin/login")
      end
  end

  defp verify_access!(conn),
    do:
      conn
      |> put_flash(:error, "Unauthorized")
      |> render(:login)

  defp has_rights("super_admin", "/admin/users"), do: true
  defp has_rights("super_admin", "/admin/users/:id"), do: true
  defp has_rights(_, _), do: false
end
