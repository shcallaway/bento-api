class AddExpiryToApiKeys < ActiveRecord::Migration[5.0]
  def change
    add_column :api_keys, :expiry, :datetime
  end
end
