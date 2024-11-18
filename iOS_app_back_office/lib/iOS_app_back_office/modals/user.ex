defmodule IOSAppBackOffice.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias IOSAppBackOffice.Wallet
  alias IOSAppBackOffice.Address
  alias __MODULE__

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

  def changeset(%User{} = user, params \\ %{}) do
    user
    |> cast(params, [:first_name, :last_name, :date_of_birth])
    |> cast_assoc(:address, with: &Address.changeset/2)
  end
end
