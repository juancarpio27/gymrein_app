class ChangeColumnNameClassDate < ActiveRecord::Migration[5.0]
  def self.up
    rename_column :class_dates, :location, :room
  end

  def self.down

  end
end
