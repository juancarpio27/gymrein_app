class AddAdminPermisionToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :admin_permission, :boolean, default: false
  end
end
