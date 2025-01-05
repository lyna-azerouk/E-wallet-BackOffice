defmodule IOSAppBackOfficeWeb.UserShowLive do
  use IOSAppBackOfficeWeb, :live_view

  import IOSAppBackOfficeWeb.CustomComponenetLive

  alias IOSAppBackOffice.Users

  def mount(%{"id" => id}, %{"admin" => admin}, socket) do
    user = Users.get_user(id)

    socket =
      socket
      |> assign(
        user: user,
        admin: admin,
        edit_property: false,
        property_name_to_edit: nil
      )

    {:ok, socket}
  end

  def handle_event("edit_property", %{"property_name_to_edit" => property_name}, socket) do
    socket =
      socket
      |> assign(:edit_property, true)
      |> assign(:property_name_to_edit, property_name)

    {:noreply, socket}
  end

  def handle_event(
        "save_property",
        %{"property_name" => property_name, "value" => value},
        socket
      ) do
    socket =
      socket.assigns.user
      |> Users.update_user(Map.new([{String.to_atom(property_name), value}]))
      |> case do
        {:ok, user} ->
          socket
          |> assign(:user, user)

        _ ->
          put_flash(socket, :error, "Error while updating the property #{property_name}")
      end

    socket =
      socket
      |> assign(:edit_property, false)
      |> assign(:property_name_to_edit, nil)

    {:noreply, socket}
  end

  def handle_event("delete", _, socket) do
    socket =
      socket.assigns.user
      |> Users.delete_user()
      |> case do
        {:ok, _} ->
          socket
          |> put_flash(:info, "User deleted succesfully")
          |> push_navigate(to: "/admin/users")

        _ ->
          socket
          |> put_flash(:info, "Error while deleting the user")
      end

    {:noreply, socket}
  end

  def handle_event("suspended", _, socket) do
    socket =
      socket.assigns.user
      |> Users.update_user_state("suspended")
      |> case do
        {:ok, user} ->
          socket |> assign(:user, user)

        {:error, _} ->
          socket
          |> put_flash(:error, "An error accured while updating the user state")
      end

    {:noreply, socket}
  end

  def handle_event("deactivated", _, socket) do
    socket =
      socket.assigns.user
      |> Users.update_user_state("deactivated")
      |> case do
        {:ok, user} ->
          socket |> assign(:user, user)

        {:error, _} ->
          socket
          |> put_flash(:error, "An error accured while updating the user state")
      end

    {:noreply, socket}
  end

  def render(%{user: user} = assigns) when not is_nil(user) do
    ~H"""
    <.navbar />
    <div class="p-6 flex h-screen">
      <div class="w-1/2">
        <div class="bg-white shadow-lg rounded-lg border p-4">
          <div class="px-4 py-4 sm:px-6 flex items-center justify-between">
            <h3 class="text-lg leading-6 font-medium text-gray-900">
              User Profile
            </h3>
            <div class="flex space-x-6 items-center">
              <.link
                navigate={~p"/admin/users/#{@user}/docusign"}
                ,
                class="items-center focus:outline-none focus:ring-2 focus:ring-blue-500 hover:bg-gray-100"
              >
                <Heroicons.icon
                  name="document"
                  type="outline"
                  class="h-6 w-4 ml-4 text-blue-500 focus:outline-none focus:ring-2 focus:ring-blue-500 hover:bg-gray-100"
                />
                <label class="text-xs text-start"> Contract </label>
              </.link>
              <button phx-click="delete" class="items-center">
                <Heroicons.icon name="trash" type="outline" class="h-6 w-4 text-red-500 ml-2" />
                <label class="text-xs"> Trash </label>
              </button>
            </div>
          </div>
          <div class="border-t border-gray-200 px-4 py-2 sm:p-0">
            <.user_ligne_show
              value={@user.first_name}
              property="first_name"
              edit_property={@edit_property}
              property_name_to_edit={@property_name_to_edit}
            />
            <.user_ligne_show
              value={@user.last_name}
              property="last_name"
              edit_property={@edit_property}
              property_name_to_edit={@property_name_to_edit}
            />
            <.user_ligne_show
              value={@user.email}
              property="email"
              edit_property={@edit_property}
              property_name_to_edit={@property_name_to_edit}
            />
            <.user_ligne_show
              value={@user.dwolla_id}
              property="dwolla_id"
              edit_property={@edit_property}
              property_name_to_edit={@property_name_to_edit}
            />
            <.user_ligne_show
              value={@user.date_of_birth}
              property="date_of_birth"
              edit_property={@edit_property}
              property_name_to_edit={@property_name_to_edit}
            />
            <.user_ligne_show
              value={@user.address.street}
              property="address"
              edit_property={@edit_property}
              property_name_to_edit={@property_name_to_edit}
            />
          </div>
        </div>

        <div class="bg-white shadow-lg rounded-lg border p-4 mt-4">
          <div class="flex items-center justify-between p-4">
            <h3 class="text-md leading-6 font-sm text-gray-900">
              Dwolla Actuel State
            </h3>
            <.badge state={@user.state} />
          </div>
          <div class="border-t border-gray-200 px-4 py-2 sm:p-0 justify-between flex">
            <button
              type="button"
              phx-click="suspended"
              class="bg-red-400 hover:bg-red-600 text-white font-medium py-2 px-2 rounded-md shadow-md flex items-center transition duration-300 ease-in-out mt-2"
            >
              Suspend User
            </button>
            <button
              type="button"
              ,
              phx-click="deactivated"
              ,
              class="bg-blue-400 hover:bg-red-600 text-white font-medium py-2 px-2 rounded-md shadow-md flex items-center transition duration-300 ease-in-out mt-2"
            >
              Deactivate User
            </button>
          </div>
        </div>
      </div>

      <div id="wallets-container" class="w-1/2">
        <%= live_render(@socket, IOSAppBackOfficeWeb.WalletsIndexLive,
          id: "wallets",
          session: %{"user" => @user}
        ) %>
      </div>
    </div>
    """
  end

  def render(%{user: _} = assigns) do
    ~H"""
    User not found
    """
  end
end
