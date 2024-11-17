defmodule IOSAppBackOfficeWeb.UserShowLive do
 use IOSAppBackOfficeWeb, :live_view

  alias IOSAppBackOffice.Users

 def mount(%{"id"=> id}, _, socket) do
  user = Users.get_user(id)

  socket = socket
  |> assign(user: user)

  {:ok,  socket}
 end

 def render(%{user: user} = assigns) when not is_nil(user) do
 ~H"""
  <div class="bg-white overflow-hidden shadow-lg rounded-lg border w-1/2 p-10 center">
    <div class="px-4 py-5 sm:px-6">
      <h3 class="text-lg leading-6 font-medium text-gray-900">
        User Profile
      </h3>
    </div>
    <div class="border-t border-gray-200 px-4 py-5 sm:p-0">
      <dl class="sm:divide-y sm:divide-gray-200">
        <div class="py-3 sm:py-5 sm:grid sm:grid-cols-3 sm:gap-4 sm:px-6">
          <dt class="text-sm font-medium text-gray-500">
            Full name
          </dt>
          <dd class="mt-1 text-sm text-gray-900 sm:mt-0 sm:col-span-2">
            <%= @user.first_name %>
          </dd>
        </div>
        <div class="py-3 sm:py-5 sm:grid sm:grid-cols-3 sm:gap-4 sm:px-6">
          <dt class="text-sm font-medium text-gray-500">
            Email
          </dt>
          <dd class="mt-1 text-sm text-gray-900 sm:mt-0 sm:col-span-2">
            <%= @user.email %>
          </dd>
        </div>
        <div class="py-3 sm:py-5 sm:grid sm:grid-cols-3 sm:gap-4 sm:px-6">
          <dt class="text-sm font-medium text-gray-500">
            Dwolla id
          </dt>
          <dd class="mt-1 text-sm text-gray-900 sm:mt-0 sm:col-span-2">
            <%= @user.dwolla_id %>
          </dd>
        </div>
        <div class="py-3 sm:py-5 sm:grid sm:grid-cols-3 sm:gap-4 sm:px-6">
          <dt class="text-sm font-medium text-gray-500">
            Address
          </dt>
          <dd class="mt-1 text-sm text-gray-900 sm:mt-0 sm:col-span-2">
          <%= @user.address.street %>
          </dd>
        </div>
      </dl>
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
