class AddDeletedAtToPackage < ActiveRecord::Migration[5.0]
  def change
    add_column :packages, :deleted_at, :datetime
  end
end
