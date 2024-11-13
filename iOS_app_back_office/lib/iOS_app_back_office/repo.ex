defmodule IOSAppBackOffice.Repo do
  use Ecto.Repo,
    otp_app: :iOS_app_back_office,
    adapter: Ecto.Adapters.Postgres
end
