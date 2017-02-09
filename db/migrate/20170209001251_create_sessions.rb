class CreateSessions < ActiveRecord::Migration[5.0]
  def change
    create_table :sessions do |t|

      t.integer :platform, limit: 1, null: false
      t.timestamp :deleted_at
      t.integer :user_id, null: false

      t.references :user, null: false
      t.references :api_key, null: false, index: true

      t.timestamps
    end
    add_foreign_key :sessions, :users
    add_foreign_key :sessions, :api_keys
  end
end
