class CreateUserPackages < ActiveRecord::Migration[5.0]
  def change
    create_table :user_packages do |t|

      t.integer :user_id, null: false
      t.integer :package_id, null: false
      t.integer :promotion_id
      t.integer :price, null: false
      t.integer :card_id, null: false

      t.timestamps
    end
    add_foreign_key :user_packages, :users
    add_foreign_key :user_packages, :packages
    add_foreign_key :user_packages, :promotions
    add_foreign_key :user_packages, :cards
  end
end
