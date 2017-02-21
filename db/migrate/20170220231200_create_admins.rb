class CreateAdmins < ActiveRecord::Migration[5.0]
  def change
    create_table :admins do |t|
      t.string :username
      t.string :password_hash
      t.string :password_salt

      t.timestamps
    end
  end
end
