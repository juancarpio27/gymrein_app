class AddColumnsToWaitingList < ActiveRecord::Migration[5.0]
  def change
    add_column :waiting_lists, :user_id, :integer
    add_column :waiting_lists, :class_date_id, :integer
  end
end
