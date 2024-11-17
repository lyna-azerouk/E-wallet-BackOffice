defmodule IOSAppBackOffice.User do
  use Ecto.Schema
  alias IOSAppBackOffice.Wallet
  alias IOSAppBackOffice.Address

  schema "users" do
    field :email, :string
    field :password, :string
    field :dwolla_id, :string
    field :first_name, :string
    field :last_name, :string
    field :date_of_birth, :date

    belongs_to :address, Address
    has_many :wallets, Wallet
  end
end
