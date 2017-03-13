class CreateWaitingLists < ActiveRecord::Migration[5.0]
  def change
    create_table :waiting_lists do |t|

      t.timestamps
    end
  end
end
