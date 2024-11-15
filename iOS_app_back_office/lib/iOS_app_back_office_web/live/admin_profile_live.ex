defmodule IOSAppBackOfficeWeb.AdminProfileLive do
  use IOSAppBackOfficeWeb, :live_view

  def mount(params, opt , socket) do
    IO.inspect("$$$$$$$$$$$$$")
    IO.inspect(opt)
    IO.inspect("$$$$$$$$$$$$$")
    IO.inspect(socket)
    {:ok, socket}
  end


  def render(assigns) do
    ~H"""
    ghelooo
    """
  end
end
