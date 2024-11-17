defmodule IOSAppBackOffice.Wallet do
  use Ecto.Schema
  alias IOSAppBackOffice.User

  @primary_key false
  schema "wallets" do
    field :csv, :string
    field :number, :string
    field :name, :string
    field :exprired_at, :date

    belongs_to :user, User, foreign_key: :user_id
  end
end
