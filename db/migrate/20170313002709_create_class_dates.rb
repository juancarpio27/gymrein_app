class CreateClassDates < ActiveRecord::Migration[5.0]
  def change
    create_table :class_dates do |t|

      t.integer :event_id, null: false
      t.integer :instructor_id, null: false
      t.integer :location_id, null: false
      t.datetime :date
      t.string :location
      t.integer :duration

      t.timestamps
    end
    add_foreign_key :class_dates, :events
    add_foreign_key :class_dates, :instructors
    add_foreign_key :class_dates, :locations
  end
end
