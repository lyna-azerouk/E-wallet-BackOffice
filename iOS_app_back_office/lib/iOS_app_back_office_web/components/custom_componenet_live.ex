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

  defp badge_class(state) do
    base_classes = "w-24 h-8 rounded-md flex items-center justify-center text-white p-2"
    color_classes = color_class(state)
    "#{base_classes} #{color_classes}"
  end

  defp color_class("verified"), do: "bg-green-400"
  defp color_class("suspended"), do: "bg-red-600"
  defp color_class(nil), do: "-"
end
