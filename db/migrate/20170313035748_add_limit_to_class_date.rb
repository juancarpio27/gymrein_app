class AddLimitToClassDate < ActiveRecord::Migration[5.0]
  def change
    add_column :class_dates, :limit, :integer
    add_column :class_dates, :available, :integer
  end
end
