defmodule IOSAppBackOffice.Repo.Migrations.AddStateToUsersTable do
  use Ecto.Migration

  def up do
    alter table("users") do
      add :state, :string
    end
  end

  def down do
    alter table("users") do
      remove :state
    end
  end
end
