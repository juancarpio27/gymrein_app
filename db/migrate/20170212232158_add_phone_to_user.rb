class AddPhoneToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :phone, :string, limit: 13
  end
end
