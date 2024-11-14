defmodule IOSAppBackOffice.Address do
  use Ecto.Schema

  schema "adsress" do
    field :country, :string
    field :city, :string
    field :region, :string
    field :postal_code, :string
    field :street, :string

    has_one :user, User
  end
end
