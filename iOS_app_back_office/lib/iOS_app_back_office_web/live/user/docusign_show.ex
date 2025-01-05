defmodule IOSAppBackOfficeWeb.UserDocusignShowLive do
  use IOSAppBackOfficeWeb, :live_view

  import IOSAppBackOfficeWeb.CustomComponenetLive

  alias IOSAppBackOffice.Users

  def mount(%{"id" => id}, %{"admin" => admin}, socket) do
    user = Users.get_user(id)

    socket =
      socket
      |> assign(docusign_url: nil, user: user, admin: admin)

    {:ok, socket}
  end

  def handle_event("create_envelope", _, socket) do
    socket =
      socket.assigns.user
      |> Users.send_document_to_sign_by_mail(socket.assigns.admin)
      |> case do
        {:ok, %{"url" => url}} ->
          socket
          |> assign(:docusign_url, url)

        _ ->
          socket
          |> put_flash(:error, "Error while creating the envelope")
      end

    {:noreply, socket}
  end

  def render(assigns) do
    ~H"""
    <.navbar />
    <div class="p-6  mt-4 w-1/2">
      <div class="bg-white shadow-lg rounded-lg border p-4">
        <div class="flex space-x-96 w-full items-center">
          <h3 class="text-md font-sm text-gray-900 mb-4">
            Send contract to Sign
          </h3>
          <button phx-click="see_contract">
            <Heroicons.icon
              name="document"
              type="outline"
              class="h-4 w-4 text-blue-500 focus:outline-none focus:ring-2 focus:ring-blue-500 hover:bg-gray-100"
            />
          </button>
        </div>
        <form class="bg-white w-full border-t border-gray-200 items-center">
          <label for="message" class="block text-sm font-medium text-gray-600 mb-2 mt-4">
            Add a comment to the Docusign document:
          </label>
          <textarea
            rows="5"
            maxlength="500"
            class="w-full p-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent"
            placeholder="Écrivez votre texte ici (500 caractères max)"
          ></textarea>
          <div class="flex space-x-4">
            <button
              type="button"
              ,
              phx-click="create_envelope"
              ,
              class="mt-4 w-full bg-blue-500 text-white py-2 px-4 rounded-lg hover:bg-blue-600 focus:outline-none focus:ring-2 focus:ring-blue-400 focus:ring-offset-2"
            >
              Get the contract & send to user
            </button>
          </div>
          <%= if assigns.docusign_url != nil do %>
            <a href={assigns.docusign_url}>Sign Document</a>
          <% end %>
        </form>
      </div>
    </div>
    """
  end
end
