class AddColumnsToReservation < ActiveRecord::Migration[5.0]
  def change
    add_column :reservations, :user_id, :integer
    add_column :reservations, :class_date_id, :integer
  end
end
