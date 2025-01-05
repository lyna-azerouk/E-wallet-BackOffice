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

  def create_admin_docusign_view(admin, user) do
    case get_user_account_info() do
      {:ok, %{account_id: account_id, access_token: access_token}} ->
        client =
          Client.new(access_token, account_id)

        create_envelope(user, admin, client)
        |> case do
          {:ok, %{"envelopeId" => envelope_id}} ->
            HTTPoison.post!(
              client.api_base_url <> "/#{envelope_id}/views/recipient",
              build_admin_view_body(admin),
              client.headers
            )
            |> case do
              %HTTPoison.Response{status_code: 201, body: body} ->
                JSON.decode(body)

              error ->
                Logger.info("Error while creating the Docusign View #{inspect(error)}")
                {:error, "Error while creating the Docusign View"}
            end

          error ->
            error
        end

      error ->
        error
    end
  end

  # def get_envelope() do
  #   case get_user_account_info() do
  #     {:ok, %{account_id: account_id, access_token: access_token}} ->
  #       client =
  #         Client.new(access_token, account_id)

  #         HTTPoison.post!(client.api_base_url <> "/#{envelope_id}", client.body, client.headers )
  #   end
  # end

  defp create_envelope(%User{} = user, admin, %Client{} = client) do
    HTTPoison.post!(
      client.api_base_url,
      build_document(user, admin),
      client.headers
    )
    |> case do
      %HTTPoison.Response{status_code: 201, body: body} ->
        JSON.decode(body)

      error ->
        Logger.info("Error while creating the envelope #{inspect(error)}")
        {:error, "Error while creating the envelope"}
    end
  end

  defp build_document(user, admin) do
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
                  "yPosition" => "700",
                  "width" => "50",
                  "height" => "14",
                  "name" => "Costumer signHere",
                  "documentId" => "1",
                  "pageNumber" => "1"
                }
              ]
            }
          },
          %{
            "email" => admin.email,
            "name" => admin.name,
            "recipientId" => "2",
            "clientUserId" => "2",
            "tabs" => %{
              "signHereTabs" => [
                %{
                  "xPosition" => "300",
                  "yPosition" => "700",
                  "width" => "50",
                  "height" => "14",
                  "name" => "Admin signHere",
                  "documentId" => "1",
                  "pageNumber" => "1"
                }
              ]
            }
          }
        ]
      }
    }
    |> JSON.encode!()
  end

  defp build_admin_view_body(admin) do
    %{
      "returnUrl" => System.get_env("DOCUSIGN_RETURN_URL") <> "/admin/users",
      "authenticationMethod" => "email",
      "recipientId" => "122",
      "email" => admin.email,
      "userName" => admin.name,
      "clientUserId" => "2"
    }
    |> JSON.encode!()
  end
end
