class AddDefaultToAssistedReservation < ActiveRecord::Migration[5.0]
  def change
    change_column :reservations, :assisted, :boolean, default: false
  end
end
