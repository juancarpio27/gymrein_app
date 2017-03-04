class AddBirthSexColumnsToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :sex, :integer
    add_column :users, :birth, :date
  end
end
