defmodule IOSAppBackOffice.Services.Dwolla.Dwolla do
  alias IOSAppBackOffice.Services.Dwolla.Client
  alias IOSAppBackOffice.User
  alias IOSAppBackOffice.Users

  def update_custumer_state(%User{dwolla_id: dwolla_id} = user, status) when not is_nil(dwolla_id) do
    client = Client.new("7K2ZSX2dVrCXeDlXw5LKAuxZk9J6LdEEj0zE3bGvPQCy23STa2")
    client = %{client | api_base_url: client.api_base_url <> "customers/#{dwolla_id}", body: Jason.encode!(%{status: status})}

    Finch.build(:post, client.api_base_url, client.headers, client.body)
    |> Finch.request(IOSAppBackOffice.Finch)
    |> case do
      {:ok, %Finch.Response{}} -> Users.update_user_state(user, status)
          |> case do
            {:ok, %User{state: state} = user} when state == status-> user
            {:error, error} -> error
          end
      {:error, _} = error -> error
    end
  end

  def update_custumer_state(_), do: {:error, nil}
end
