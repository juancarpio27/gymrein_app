class CreatePromotions < ActiveRecord::Migration[5.0]
  def change
    create_table :promotions do |t|

      t.string :code, limit: 10, null: false
      t.integer :type, null: false
      t.datetime :expiration, null: false
      t.integer :amount, null: false

      t.timestamps
    end
  end
end
