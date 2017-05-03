class AddDeviceIdToSession < ActiveRecord::Migration[5.0]
  def change
    add_column :sessions, :device_id, :string, default: ""
  end
end
