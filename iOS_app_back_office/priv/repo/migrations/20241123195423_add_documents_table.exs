defmodule IOSAppBackOffice.Repo.Migrations.AddDocumentsTable do
  use Ecto.Migration

  def change do
    create table("documents") do
      add :name, :string
      add :type, :string
      add :hash, :string
      add :path, :string
    end
  end
end
