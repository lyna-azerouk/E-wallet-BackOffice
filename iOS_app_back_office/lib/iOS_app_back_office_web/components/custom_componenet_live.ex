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

  def user_ligne_show(assigns) do
    ~H"""
      <div class="py-3 sm:py-5 sm:grid sm:grid-cols-3 sm:gap-4 sm:px-6">
        <dt class="text-sm font-medium text-gray-500">
          <%= @property %>
        </dt>
        <dd class="mt-1 text-sm text-gray-900 sm:mt-0">
          <%= @value %>
        </dd>
        <dd class="flex justify-end items-center">
          <Heroicons.icon name="pencil-square" type="outline" class="h-4 w-4" />
        </dd>
      </div>
    """
  end
end
