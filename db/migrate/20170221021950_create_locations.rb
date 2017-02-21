class CreateLocations < ActiveRecord::Migration[5.0]
  def change
    create_table :locations do |t|

      t.string :name, null: false
      t.string :address, null: false
      t.time :opening_hour, null: false
      t.time :closing_hour, null: false

      t.timestamps
    end
  end
end
