defmodule IOSAppBackOffice.Services.Dwolla.Dwolla do
  alias IOSAppBackOffice.Services.Dwolla.Client
  alias IOSAppBackOffice.User

  def update_custumer_state(%User{dwolla_id: dwolla_id} = user, status)
      when not is_nil(dwolla_id) do
    client = Client.new("0i5tIvfIasQJvIUifM9vbFgUGmygGhzBGafYqxJD2qDBhpUpJt")

    client = %{
      client
      | api_base_url: client.api_base_url <> "customers/#{dwolla_id}",
        body: Jason.encode!(%{status: status})
    }
    Finch.build(:post, client.api_base_url, client.headers, client.body)
    |> Finch.request(IOSAppBackOffice.Finch)
    |> case do
      {:ok, %Finch.Response{}}  = response ->
        {:ok, user}

      response ->
        {:error, "error occured while updating the user state"}
    end
  end

  def update_custumer_state(_), do: {:error, nil}
end
