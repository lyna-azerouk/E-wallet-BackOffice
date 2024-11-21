defmodule IOSAppBackOfficeWeb.UserIndexLive do
  use IOSAppBackOfficeWeb, :live_view
  import IOSAppBackOfficeWeb.CustomComponenetLive

  alias IOSAppBackOffice.Users

  @impl true
  def mount(_params, %{"admin" => _admin}, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(_, _, socket) do
    users_paginated = Users.paginate_users()

    socket =
      socket
      |> assign(:users_paginated, users_paginated)

    {:noreply, socket}
  end

  @impl true
  def handle_event("nav", %{"page" => page}, socket) do
    users_paginated = Users.paginate_users(page: page)

    socket =
      socket
      |> assign(:users_paginated, users_paginated)

    {:noreply, socket}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <.navbar />
    <div class="overflow-y-hidden rounded-lg mt-6 p-10 items-center jutify-center">
      <div class="overflow-x-auto rounded">
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
            <.user_resume user={user}></.user_resume>
          <% end %>
        </table>
        <nav class="items-center justify-center mt-8">
          <ul class="flex items-center -space-x-px h-10 text-sm items-center justify-center">
            <%= for idx <- Enum.to_list(1..@users_paginated.total_pages) do %>
              <li>
                <a
                  class={"flex items-center justify-center px-4 h-8 ms-0 leading-tight text-gray-500 bg-white border border-e-0 border-gray-300 rounded-lg hover:bg-gray-100 hover:text-gray-700 dark:border-gray-700 dark:text-gray-400 dark:hover:bg-gray-700 dark:hover:text-white " <> if @users_paginated.page_number == idx, do: " pointer-events-none text-gray-600", else: ""}
                  href="#"
                  ,
                  phx-click="nav"
                  ,
                  phx-value-page={idx}
                >
                  <%= idx %>
                </a>
              </li>
            <% end %>
            <li>
              <a
                class={"flex items-center justify-center px-4 h-8 leading-tight text-gray-500 bg-white border border-gray-300 rounded-lg hover:bg-gray-100 hover:text-gray-700 dark:border-gray-700 dark:text-gray-400 dark:hover:bg-gray-700 dark:hover:text-white" <> if @users_paginated.page_number >= @users_paginated.total_pages, do: " pointer-events-none text-gray-600", else: ""}
                href="#"
                ,
                phx-click="nav"
                ,
                phx-value-page={@users_paginated.page_number + 1}
              >
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
