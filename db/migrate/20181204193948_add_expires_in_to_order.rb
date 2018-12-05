class AddExpiresInToOrder < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :expires_in, :datetime
  end
end
