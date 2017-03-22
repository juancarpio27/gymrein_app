class AddAssistedColumnToReservation < ActiveRecord::Migration[5.0]
  def change
    add_column :reservations, :assisted, :boolean
  end
end
