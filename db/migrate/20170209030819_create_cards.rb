class CreateCards < ActiveRecord::Migration[5.0]
  def change
    create_table :cards do |t|

      t.string :holder_name, limit: 120, null: false
      t.string :number, limit: 4, null: false
      t.integer :expiration_month, null: false
      t.integer :expiration_year, null: false
      t.string :brand, limit: 75, null: false

      t.integer :user_id, null: false

      t.references :user, null: false


      t.timestamps
    end
    add_foreign_key :cards, :users
  end
end
