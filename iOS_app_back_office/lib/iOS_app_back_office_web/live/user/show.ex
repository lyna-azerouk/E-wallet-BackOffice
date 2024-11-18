defmodule IOSAppBackOfficeWeb.UserShowLive do
 use IOSAppBackOfficeWeb, :live_view

 import Heroicons
 import IOSAppBackOfficeWeb.CustomComponenetLive

  alias IOSAppBackOffice.Users

 def mount(%{"id"=> id}, _, socket) do
  user = Users.get_user(id)

  socket = socket
  |> assign(user: user)

  {:ok,  socket}
 end

 def render(%{user: user} = assigns) when not is_nil(user) do
 ~H"""
  <div class="p-10">
    <div class="bg-white shadow-lg rounded-lg border w-1/2 p-8">
      <div class="px-4 py-5 sm:px-6">
        <h3 class="text-lg leading-6 font-medium text-gray-900">
          User Profile
        </h3>
      </div>
      <div class="border-t border-gray-200 px-4 py-5 sm:p-0">
        <.user_ligne_show value={@user.first_name} property={"Full Name"}/>
        <.user_ligne_show value={@user.email} property={"Email"}/>
        <.user_ligne_show value={@user.dwolla_id} property={"Dwolla Ids"}/>
        <.user_ligne_show value={"verified"} property={"Status"}/>
       <.user_ligne_show value={"@user.address.street"} property={"Address"}/>
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
