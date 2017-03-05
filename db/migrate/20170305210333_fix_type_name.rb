class FixTypeName < ActiveRecord::Migration[5.0]
  def self.up
    rename_column :promotions, :type, :promotion_type
  end

  def self.down

  end
end
