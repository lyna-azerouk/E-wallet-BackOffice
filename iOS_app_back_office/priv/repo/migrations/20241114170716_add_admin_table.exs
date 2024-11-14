defmodule IOSAppBackOffice.Repo.Migrations.AddAdminTable do
  use Ecto.Migration

  def up do
    create table("admin") do
      add :email, :string
      add :password, :string
      add :name, :string
      add :role, :string
    end
  end

  def down do
    drop table("admin")
  end
end
