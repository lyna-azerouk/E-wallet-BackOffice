defmodule IOSAppBackOfficeWeb.CustomComponenetLive do
  use IOSAppBackOfficeWeb, :html

  def user_resume(assigns) do
    ~H"""
    <tbody class="text-gray-500">
      <td class="border-b border-gray-200 bg-white px-5 py-5 text-sm">
        <p class="whitespace-no-wrap"><%= @user.id %></p>
      </td>
      <td class="border-b border-gray-200 bg-white px-5 py-5 text-sm">
        <div class="flex items-center">
          <div class="ml-3">
            <p class="whitespace-no-wrap"><%= @user.email %></p>
          </div>
        </div>
      </td>
      <td class="border-b border-gray-200 bg-white px-5 py-5 text-sm">
        <p class="whitespace-no-wrap">Administrator</p>
      </td>
      <td class="border-b border-gray-200 bg-white px-5 py-3 text-sm">
        <p class="whitespace-no-wrap">
          <.badge state={@user.state} />
        </p>
      </td>
      <td class="w-1/12 whitespace-no-wrap">
        <.link class="text-sm mr-1" navigate={~p"/admin/users/#{@user.id}"}> Show </.link>
      </td>
    </tbody>
    """
  end

  def user_ligne_show(assigns) do
    ~H"""
    <div class="py-2 sm:py-4 sm:grid sm:grid-cols-3 sm:gap-4 sm:px-6">
      <dt class="text-sm font-medium text-gray-500">
        <%= @property %>
      </dt>
      <dd class="mt-1 text-sm text-gray-900 sm:mt-0">
        <%= if @edit_property && @property_name_to_edit == @property do %>
          <input
            type="text"
            value={@value}
            phx-blur="save_property"
            phx-change="save_property"
            class="border-gray-300 rounded-md px-2 shadow-md"
            phx-value-property_name={@property}
          />
        <% else %>
          <%= @value %>
        <% end %>
      </dd>
      <dd class="flex justify-end items-center">
        <button phx-click="edit_property" , phx-value-property_name_to_edit={@property}>
          <Heroicons.icon name="pencil-square" type="outline" class="h-4 w-4 text-blue-500" />
        </button>
      </dd>
    </div>
    """
  end

  def badge(assigns) do
    ~H"""
    <p class={badge_class(@state)} aria-label={"State badge for #{@state}"}>
      <%= @state %>
    </p>
    """
  end

  def navbar(assigns) do
    ~H"""
     <header
      class="inset-x-100 top-0  mx-auto w-2/3 mt-2 border border-gray-100 bg-white/80 py-3 shadow backdrop-blur-lg md:top-6 md:rounded-3xl">
      <div class="px-4">
        <div class="flex items-center justify-between">
          <div class="flex shrink-0">
            <a aria-current="page" class="flex items-center" href="/">
              <Heroicons.icon name="wallet" type="solid" class="h-8 w-8" />
              <p class="ml-2 text-xl"> E-wallet BO</p>
            </a>
          </div>
          <div class="hidden md:flex md:items-center md:justify-center md:gap-5">
            <a class="inline-block rounded-lg px-2 py-1 text-sm font-medium text-gray-900 transition-all duration-200 hover:bg-gray-100 hover:text-gray-900"
              href="#">
              <Heroicons.icon name="user-circle" type="outline" class="h-8 w-8" />
            </a>
          </div>
        </div>
      </div>
      </header>
    """
  end

  def menu(assigns) do
    ~H"""
    <div class="flex bg-gray-50 w-1/6">
      <div class="hidden md:flex md:w-64 md:flex-col shadow-xl">
        <div class="flex flex-col flex-grow overflow-y-auto bg-white">
          <div class="flex flex-col flex-1 px-3">
            <div class="space-y-2">
              <nav class="flex-1 space-y-1">
                <a href="#" title="" class="flex items-center px-4 py-2.5 text-sm font-medium text-white transition-all duration-200 bg-indigo-600 rounded-lg group">
                  Dashboard
                </a>
                <a href="#" class="flex items-center px-4 py-2.5 text-sm font-medium transition-all duration-200 text-gray-900 hover:text-white rounded-lg hover:bg-indigo-600 group">
                  <Heroicons.icon name="users" type="outline" class="h-6 w-6 mr-4" />
                  Customers
                </a>
              </nav>
              <hr class="border-gray-200" />
              <nav class="flex-1 space-y-1">
                <a href="#" class="flex items-center px-4 py-2.5 text-sm font-medium transition-all duration-200 text-gray-900 hover:text-white rounded-lg hover:bg-indigo-600 group">
                  <Heroicons.icon name="chart-bar" type="outline" class="h-6 w-6 mr-4" />
                  Analytics
                </a>
              </nav>
              <hr class="border-gray-200" />
              <nav class="flex-1 space-y-1">
                <a href="#" class="flex items-center px-4 py-2.5 text-sm font-medium transition-all duration-200 text-gray-900 hover:text-white rounded-lg hover:bg-indigo-600 group">
                  <Heroicons.icon name="cog-8-tooth" type="outline" class="h-6 w-6 mr-4" />
                  Settings
                </a>
              </nav>
            </div>
          </div>
        </div>
      </div>
    </div>
    """
  end

  defp badge_class(state) do
    base_classes = "w-24 h-8 rounded-md flex items-center justify-center text-white p-2"
    color_classes = color_class(state)
    "#{base_classes} #{color_classes}"
  end

  defp color_class("verified"), do: "bg-green-400"
  defp color_class("suspended"), do: "bg-red-600"
  defp color_class("desactivated"), do: "bg-gray-200"
  defp color_class(nil), do: "-"
end
