class AddLogoColumnsToEvents < ActiveRecord::Migration[5.0]
  def up
    add_attachment :events, :logo
  end

  def down
    remove_attachment :events, :logo
  end
end
