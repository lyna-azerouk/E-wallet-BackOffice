defmodule IOSAppBackOffice.Services.Dwolla.Client do
  @type t :: %__MODULE__{}
  defstruct api_base_url: nil,
            headers: nil,
            body: nil

  def new(token) do
    %__MODULE__{
      api_base_url: "https://api-sandbox.dwolla.com/",
      headers: [
        {"Content-Type", "application/json"},
        {"Accept", "application/vnd.dwolla.v1.hal+json"},
        {"Authorization", "Bearer #{token}"}
      ],
      body: %{}
    }
  end

  def new do
    %__MODULE__{
      api_base_url: "https://api-sandbox.dwolla.com/token",
      headers: [
        {"Content-Type", "application/x-www-form-urlencoded"},
        {"Authorization", "Basic #{get_credentials()}"}
      ],
      body: "grant_type=client_credentials"
    }
  end

  defp get_credentials() do
    "#{System.get_env("DWOLLA_CLIENT_ID")}:#{System.get_env("DWOLLA_SECRET_KEY")}"
    |> IO.inspect()
    |> Base.encode64()
  end
end
