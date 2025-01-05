defmodule IOSAppBackOffice.Services.Docusign.Client do
  use Joken.Config

  @type t :: %__MODULE__{}

  defstruct api_base_url: nil,
            headers: nil,
            body: nil

  def new() do
    %__MODULE__{
      api_base_url: get_api_base_url() <> "/oauth/token",
      headers: [
        {"Authorization", "Basic #{get_encoded_secret_and_integration_key()}"},
        {"Content-Type", "application/x-www-form-urlencoded"}
      ],
      body:
        URI.encode_query(%{
          "grant_type" => "urn:ietf:params:oauth:grant-type:jwt-bearer",
          "assertion" => calculate_jwt_token()
        })
    }
  end

  def new(bearer_token) when not is_nil(bearer_token) do
    %__MODULE__{
      api_base_url: get_api_base_url() <> "/oauth/userinfo",
      headers: [
        {"Authorization", "Bearer #{bearer_token}"}
      ]
    }
  end

  def new(bearer_token, account_id) when not is_nil(bearer_token) and not is_nil(account_id) do
    %__MODULE__{
      api_base_url: "https://demo.docusign.net/restapi/v2.1/accounts/#{account_id}/envelopes",
      headers: [
        {"Authorization", "Bearer #{bearer_token}"},
        {"Accept", "application/json"},
        {"Content-Type", "application/json; charset=UTF-8"}
      ]
    }
  end

  defp get_encoded_secret_and_integration_key() do
    "#{get_integrator_key()}:#{get_secret_key()}"
    |> Base.encode64()
  end

  defp calculate_jwt_token do
    rsa_private_jwk = JOSE.JWK.from_pem_file("rsa-2048.pem")

    jws = %{
      "alg" => "RS256"
    }

    jwt = %{
      iss: get_integrator_key(),
      sub: get_user_id(),
      aud: "account-d.docusign.com",
      iat: :os.system_time(:seconds),
      exp: :os.system_time(:seconds) + 36000 * 24,
      scope: "signature"
    }

    {_, assertion} =
      JOSE.JWT.sign(rsa_private_jwk, jws, jwt)
      |> JOSE.JWS.compact()

    assertion
  end

  defp get_api_account_id do
    System.get_env("DOCUSIGN_API_ACCOUNT_ID")
  end

  defp get_user_id do
    System.get_env("DOCUSIGN_USER_ID")
  end

  defp get_secret_key do
    System.get_env("DOCUSIGN_SECRET_KEY")
  end

  defp get_integrator_key do
    System.get_env("DOCUSIGN_INTEGRATOR_KEY")
  end

  defp get_api_base_url do
    System.get_env("DOCUSIGN_API_BASE_URL")
  end
end
