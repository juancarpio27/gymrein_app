class ChangeTypeAccesTokenApiKey < ActiveRecord::Migration[5.0]
  def change
    change_column :api_keys, :access_token, :string, limit: 64
  end
end
