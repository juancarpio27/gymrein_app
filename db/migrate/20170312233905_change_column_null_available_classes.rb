class ChangeColumnNullAvailableClasses < ActiveRecord::Migration[5.0]
  def change
    change_column_null :users, :available_classes, false
  end
end
