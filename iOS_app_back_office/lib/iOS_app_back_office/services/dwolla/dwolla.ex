defmodule IOSAppBackOffice.Services.Dwolla.Dwolla do
  alias IOSAppBackOffice.Services.Dwolla.Client
  alias IOSAppBackOffice.User

  def update_custumer_state(%User{dwolla_id: dwolla_id} = user, status)
      when not is_nil(dwolla_id) do
    client = Client.new(get_token())

    client = %{
      client
      | api_base_url: client.api_base_url <> "customers/#{dwolla_id}",
        body: Jason.encode!(%{status: status})
    }

    Finch.build(:post, client.api_base_url, client.headers, client.body)
    |> Finch.request(IOSAppBackOffice.Finch)
    |> case do
      {:ok, %Finch.Response{status: 200}} ->
        {:ok, user}

      _ ->
        {:error, "error occured while updating the user state"}
    end
  end

  def update_custumer_state(_, _), do: {:error, ""}

  def update_user(%User{dwolla_id: dwolla_id} = user, params) when not is_nil(dwolla_id) do
    client = Client.new(get_token())

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

      _ ->
        {:error, "error occured while updating the user state"}
    end
  end

  def update_user(_, _), do: {:error, ""}

  defp get_token() do
    client = Client.new()

    Finch.build(:post, client.api_base_url, client.headers, client.body)
    |> Finch.request(IOSAppBackOffice.Finch)
    |> case do
      {:ok, %Finch.Response{status: 200, body: body}} ->
        {:ok, %{"access_token" => access_token}} = Jason.decode(body)
        access_token

      _ ->
        {:error, "error occured while updating the user state"}
    end
  end
end
