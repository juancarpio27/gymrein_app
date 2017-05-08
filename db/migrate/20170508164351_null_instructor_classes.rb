class NullInstructorClasses < ActiveRecord::Migration[5.0]
  def change
    change_column_null :class_dates, :instructor_id, true
  end
end
