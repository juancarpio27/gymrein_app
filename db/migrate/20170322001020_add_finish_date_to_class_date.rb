class AddFinishDateToClassDate < ActiveRecord::Migration[5.0]
  def change
    add_column :class_dates, :finish, :datetime
  end
end
