defmodule IOSAppBackOffice.Repo.Migrations.AddFirstAdminUser do
  use Ecto.Migration
  import Bcrypt, only: [hash_pwd_salt: 1]

  def up do
    hashed_password = hash_pwd_salt("motdepasse_secure")

    execute "
      INSERT INTO admin (email, password, role) VALUES ('admin@bo.fr', '#{hashed_password}', 'super_admin')
      "
  end

  def down do
    execute "
     DELETE FROM admin WHERE email='admin@bo.fr'
    "
  end
end
