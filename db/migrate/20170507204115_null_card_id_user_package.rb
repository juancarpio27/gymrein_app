class NullCardIdUserPackage < ActiveRecord::Migration[5.0]
  def change
    change_column_null :user_packages, :card_id, true
  end
end
