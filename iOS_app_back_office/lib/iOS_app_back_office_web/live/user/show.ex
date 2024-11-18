defmodule IOSAppBackOfficeWeb.UserShowLive do
 use IOSAppBackOfficeWeb, :live_view

 import Heroicons
 import IOSAppBackOfficeWeb.CustomComponenetLive

  alias IOSAppBackOffice.Users

 def mount(%{"id"=> id}, _, socket) do
  user = Users.get_user(id)

  socket = socket
  |> assign(user: user, edit_property: false, property_name_to_edit: nil)

  {:ok,  socket}
 end

 def handle_event("edit_property", %{"property_name_to_edit" => property_name}, socket) do
    socket = socket
            |> assign(:edit_property, true)
            |> assign(:property_name_to_edit, property_name)
    {:noreply, socket}
 end

 def handle_event("save_property", %{"property_name" => property_name, "value" => value } = params, socket) do
  socket = socket.assigns.user
  |> Users.update_user(Map.new([{String.to_atom(property_name), value}]))
  |> case do
    {:ok, user} ->
      socket
      |> assign(:user, user)

    _ -> put_flash(socket, :error, "Error while updating the property #{property_name}")
  end

  socket = socket
  |> assign(:edit_property, false)
  |> assign(:property_name_to_edit, nil)

  {:noreply, socket}

 end

 def render(%{user: user} = assigns) when not is_nil(user) do
 ~H"""
  <div class="p-6">
    <div class="bg-white shadow-lg rounded-lg border w-1/2 p-4">
      <div class="px-4 py-4 sm:px-6 flex items-center justify-between">
        <h3 class="text-lg leading-6 font-medium text-gray-900">
          User Profile
        </h3>
        <button phx-click="" class="flex items-center">
          <Heroicons.icon name="trash" type="outline" class="h-6 w-4 text-red-500" />
        </button>
      </div>
      <div class="border-t border-gray-200 px-4 py-2 sm:p-0">
        <.user_ligne_show value={@user.first_name} property={"first_name"} edit_property={@edit_property} property_name_to_edit={@property_name_to_edit}/>
        <.user_ligne_show value={@user.last_name} property={"last_name"} edit_property={@edit_property} property_name_to_edit={@property_name_to_edit}/>
        <.user_ligne_show value={@user.email} property={"email"} edit_property={@edit_property} property_name_to_edit={@property_name_to_edit}/>
        <.user_ligne_show value={@user.dwolla_id} property={"dwolla_id"} edit_property={@edit_property} property_name_to_edit={@property_name_to_edit}/>
        <.user_ligne_show value={"verified"} property={"Status"} edit_property={@edit_property} property_name_to_edit={@property_name_to_edit}/>
        <.user_ligne_show value={@user.address.street} property={"address"} edit_property={@edit_property} property_name_to_edit={@property_name_to_edit}/>
      </div>
    </div>
  </div>
  """
 end

 def render(%{user: _}= assigns) do
  ~H"""
    User not found
  """
 end
end
