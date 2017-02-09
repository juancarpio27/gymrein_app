class CreateApiKeys < ActiveRecord::Migration[5.0]
  def change
    create_table :api_keys do |t|
      t.string :access_token
      t.integer :user_id

      t.references :user, null: false

      t.timestamps
    end

    add_foreign_key :api_keys, :users
  end
end
