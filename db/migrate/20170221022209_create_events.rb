class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|

      t.string :name, limit: 75, null: false
      t.text :description

      t.timestamps
    end
  end
end
