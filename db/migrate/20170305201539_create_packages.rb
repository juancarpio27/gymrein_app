class CreatePackages < ActiveRecord::Migration[5.0]
  def change
    create_table :packages do |t|

      t.string :name, limit: 100, null: false
      t.integer :price, null: false
      t.integer :classes, null: false

      t.timestamps
    end
  end
end
