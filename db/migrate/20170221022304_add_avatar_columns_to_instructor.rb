class AddAvatarColumnsToInstructor < ActiveRecord::Migration[5.0]
  def up
    add_attachment :instructors, :avatar
  end

  def down
    remove_attachment :instructors, :avatar
  end
end
