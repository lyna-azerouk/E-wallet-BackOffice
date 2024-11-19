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
      {:ok, %Finch.Response{}} ->
        {:ok, user}

      _ ->
        {:error, "error occured while updating the user state"}
    end
  end

  def update_custumer_state(_), do: {:error, ""}

  def update_user(%User{dwolla_id: dwolla_id} = user, params) when not is_nil(dwolla_id) do
    client = Client.new("SHclrsKfdYziUtlCczsJgzWXfA98QrhQiexhOF8BgOkWrLaZpt")

    client = %{
      client
      | api_base_url: client.api_base_url <> "customers/#{dwolla_id}",
        body: Jason.encode!(params)
    }

    Finch.build(:post, client.api_base_url, client.headers, client.body)
    |> Finch.request(IOSAppBackOffice.Finch)
    |> case do
      {:ok, %Finch.Response{}} ->
        {:ok, user}

      response -> IO.inspect(response)
        {:error, "error occured while updating the user state"}
    end
  end

  def update_user(_, _), do: {:error, ""}
end
