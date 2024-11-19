defmodule IOSAppBackOffice.Services.Dwolla.Client do
  @type t :: %__MODULE__{}
  defstruct api_base_url: nil,
            headers: nil,
            body: nil

  # def new do
  #   %__MODULE__{
  #     api_base_url: "https://api-sandbox.dwolla.com/token",
  #     headers: [
  #       {"Content-Type", "application/json"},
  #       {"Accept", "application/json"},
  #       {"Authorization", "Basic #{encode_credentials()}"}
  #     ]
  #   }
  # end

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

  defp encode_credentials() do
    credentials =
      "IEo2kvbFJ1mwwHUYqFZ30shh7iZxJ5ATaZiDyEmNgqPtltuQ7T:IEo2kvbFJ1mwwHUYqFZ30shh7iZxJ5ATaZiDyEmNgqPtltuQ7T"
  end
end
