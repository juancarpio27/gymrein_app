class AddDefaultToAvailableClasses < ActiveRecord::Migration[5.0]
  def change
    change_column :users, :available_classes, :integer, null: false, default: 0
  end
end
