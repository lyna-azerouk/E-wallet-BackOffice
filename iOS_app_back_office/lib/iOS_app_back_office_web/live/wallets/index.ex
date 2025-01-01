defmodule IOSAppBackOfficeWeb.WalletsIndexLive do
  use IOSAppBackOfficeWeb, :live_view

  def mount(params, %{"user" => user}, socket) do
    {:ok, socket |> assign(:user, user)}
  end

  def render(assigns) do
    ~H"""
    <div class="pl-2">
      <div class="bg-white shadow-lg rounded-lg border p-4 h-1/2">
        <div class="px-4 py-4 border-b border-gray-200">
          <h3 class="text-lg leading-6 font-medium text-gray-900">Wallets</h3>
        </div>
        <table class="table-auto w-full text-left">
          <thead>
            <tr class="text-sm font-medium text-gray-500 border-b border-gray-200">
              <th class="px-4 py-3">Card name</th>
              <th class="px-6 py-3">Progress</th>
              <th class="px-6 py-3">Amount</th>
              <th class="px-2 py-2">Expired date</th>
              <th class="px-6 py-3"></th>
            </tr>
          </thead>
          <tbody class="text-sm">
            <%= for wallet <- @user.wallets do %>
              <tr class="border-b">
                <td class="px-6 py-4">Acme <%= wallet.name %></td>
                <td class="px-6 py-4">
                  <div class="w-full bg-gray-200 rounded-full h-2">
                    <div class="bg-blue-500 h-2 rounded-full" style="width: 50%;"></div>
                  </div>
                </td>
                <td class="px-6 py-4 flex items-center space-x-2">
                  10000 $
                </td>
                <td class="px-6 py-4"><%= wallet.exprired_at %></td>
                <td class="px-6 py-4 text-right">
                  <button phx-click="show_wallet">
                    <Heroicons.icon name="eye" type="outline" class="h-5 w-5 text-blue-500" />
                  </button>
                </td>
              </tr>
            <% end %>
          </tbody>
        </table>
      </div>
    </div>
    """
  end
end
