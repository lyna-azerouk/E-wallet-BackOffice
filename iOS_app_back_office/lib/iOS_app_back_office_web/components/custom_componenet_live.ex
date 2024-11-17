defmodule IOSAppBackOfficeWeb.CustomComponenetLive do
  use IOSAppBackOfficeWeb, :html

  def user_resume(assigns) do
    ~H"""
      <tbody class ="text-gray-500">
        <td class="border-b border-gray-200 bg-white px-5 py-5 text-sm">
          <p class="whitespace-no-wrap"> <%= @user.id %> </p>
        </td>
        <td class="border-b border-gray-200 bg-white px-5 py-5 text-sm">
          <div class="flex items-center">
            <div class="ml-3">
              <p class="whitespace-no-wrap"> <%= @user.email %> </p>
            </div>
          </div>
        </td>
        <td class="border-b border-gray-200 bg-white px-5 py-5 text-sm">
          <p class="whitespace-no-wrap">Administrator</p>
        </td>
        <td class="border-b border-gray-200 bg-white px-5 py-5 text-sm">
          <p class="whitespace-no-wrap">Active</p>
        </td>
        <td class="w-1/12 whitespace-no-wrap">
          <.link class="text-sm mr-1" navigate={~p"/admin/users/#{@user.id}"}> Show </.link>
        </td>
      </tbody>
    """
  end
end
