defmodule IOSAppBackOffice.Services.Docusign.Docusign do
  require Logger

  alias IOSAppBackOffice.Services.Docusign.Client
  alias IOSAppBackOffice.User

  def oauth() do
    client = Client.new()

    Finch.build(:post, client.api_base_url, client.headers, client.body)
    |> Finch.request(IOSAppBackOffice.Finch)
    |> case do
      {:ok, %Finch.Response{status: 200, body: body}} ->
        JSON.decode(body)

      _ ->
        {:error, "Error while authentification to Docusign"}
    end
  end

  def get_user_account_info() do
    oauth()
    |> case do
      {:ok, %{"access_token" => access_token}} ->
        client = Client.new(access_token)

        Finch.build(:get, client.api_base_url, client.headers)
        |> Finch.request(IOSAppBackOffice.Finch)
        |> case do
          {:ok, %Finch.Response{status: 200, body: body}} ->
            {:ok, %{"accounts" => [%{"account_id" => account_id} | _]}} = JSON.decode(body)
            {:ok, %{account_id: account_id, access_token: access_token}}

          _ ->
            Logger.info("Error while getting user account info")
            {:error, "Error while getting user account info"}
        end

      {:error, _} ->
        Logger.info("Error while getting authentification token")
        {:error, "Error while getting authentification token"}
    end
  end

  def create_envelope(%User{} = user) do
    case get_user_account_info() do
      {:ok, %{account_id: account_id, access_token: access_token}} ->
        client =
          Client.new(access_token, account_id)

        Finch.build(
          :post,
          client.api_base_url,
          client.headers,
          JSON.encode!(build_document(user))
        )
        |> Finch.request(IOSAppBackOffice.Finch)
        |> case do
          {:ok, %Finch.Response{status: 201}} ->
            {:ok, "Envelope created"}

          error ->
            IO.inspect(error)
            Logger.info("Error while creating the envelope #{inspect(error)}")
            {:error, "Error while creating the envelope"}
        end

      {:error, _} ->
        Logger.info("Error while getting users info")
        {:error, "Error while getting users info"}
    end
  end

  defp build_document(user) do
    {:ok, file_to_sign} =
      File.read(
        "/Users/smart-it/Documents/personal/IOS-APP-BackOffice/IOS-APP-BackOffice/iOS_app_back_office/priv/static/docusign.pdf"
      )

    %{
      "emailSubject" => "Veuillez signer ce document",
      "status" => "sent",
      "documents" => [
        %{
          "documentId" => "1",
          "documentBase64" => Base.encode64(file_to_sign),
          "name" => "Document recap wallet",
          "fileExtension" => "pdf"
        }
      ],
      "recipients" => %{
        "signers" => [
          %{
            "email" => user.email,
            "name" => user.first_name,
            "recipientId" => user.id,
            "tabs" => %{
              "signHereTabs" => [
                %{
                  "xPosition" => "400",
                  "yPosition" => "600",
                  "width" => "50",
                  "height" => "14",
                  "name" => "signHere",
                  "documentId" => "1",
                  "pageNumber" => "1"
                }
              ]
            }
          }
        ]
      }
    }
  end
end
