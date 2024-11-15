defmodule IOSAppBackOffice.Admin do
  import Bcrypt

  use Ecto.Schema

  schema "admin" do
    field :name, :string
    field :email, :string
    field :password, :string
    field(:role, Ecto.Enum, values: [:super_admin, :read, :read_and_write])
  end
end
