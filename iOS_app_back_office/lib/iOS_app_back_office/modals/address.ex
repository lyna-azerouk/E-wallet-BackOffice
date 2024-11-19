defmodule IOSAppBackOffice.Address do
  use Ecto.Schema
  import Ecto.Changeset

  alias IOSAppBackOffice.Address
  alias __MODULE__

  schema "addresses" do
    field :country, :string
    field :city, :string
    field :region, :string
    field :postal_code, :string
    field :street, :string

    has_one :user, User
  end

  def changeset(%Address{} = address, params \\ %{}) do
    address
    |> cast(params, [:country, :city, :region, :postal_code, :street])
  end
end
