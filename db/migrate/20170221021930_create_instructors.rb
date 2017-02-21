class CreateInstructors < ActiveRecord::Migration[5.0]
  def change
    create_table :instructors do |t|

      t.string :name, limit: 75, null: false
      t.string :lastname, limit: 75, null: false
      t.text :biography

      t.timestamps
    end
  end
end
