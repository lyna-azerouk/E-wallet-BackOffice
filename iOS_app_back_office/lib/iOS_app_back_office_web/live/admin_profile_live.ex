defmodule IOSAppBackOfficeWeb.AdminProfileLive do
  use IOSAppBackOfficeWeb, :live_view
  import IOSAppBackOfficeWeb.CustomComponenet

  alias  IOSAppBackOffice.Users

  @impl true
  def mount(_params, %{"admin" => admin} , socket) do
    socket
    |>assign(admin: admin)
    |>assign(conn: socket)
    {:ok, socket}
  end

  @impl true
  def handle_params( _ , _ , socket) do
    users_paginated = Users.paginate_users()

    socket = socket
    |> assign(:users_paginated, users_paginated)

    {:noreply, socket}
  end

  @impl true
  def handle_event("nav", %{"page" => page}, socket) do
    users_paginated = Users.paginate_users(page: page)

    socket = socket
    |> assign(:users_paginated, users_paginated)
    {:noreply, socket}
  end

  @impl true
  def render(assigns) do
  ~H"""
    <div class="overflow-y-hidden rounded-lg border p-10">
      <div class="overflow-x-auto">
        <table class="w-full">
        <thead>
          <tr class="bg-blue-600 text-left text-xs font-semibold uppercase tracking-widest text-white">
            <th class="px-5 py-3">ID</th>
            <th class="px-5 py-3">Email</th>
            <th class="px-5 py-3">User Role</th>
            <th class="px-5 py-3">Status</th>
            <th class="px-5 py-3">Actions</th>
          </tr>
        </thead>
        <%= for user <- @users_paginated.entries do %>
          <.user_resume user={user}>
          </.user_resume>
        <% end %>
        </table>
        <nav class="border-t border-gray-200 center">
          <ul class="flex my-2">
            <%= for idx <- Enum.to_list(1..@users_paginated.total_pages) do %>
              <li>
                <a class={"px-2 py-2 " <> if @users_paginated.page_number == idx, do: " pointer-events-none text-gray-600", else: ""} href="#", phx-click="nav", phx-value-page={idx}>
                  <%= idx %>
                </a>
              </li>
            <% end %>
            <li>
              <a class={"px-2 py-2 " <> if @users_paginated.page_number >= @users_paginated.total_pages, do: " pointer-events-none text-gray-600", else: ""} href="#", phx-click="nav", phx-value-page={@users_paginated.page_number + 1}>
                Next
              </a>
            </li>
          </ul>
        </nav>
      </div>
    </div>
    """
  end
end
