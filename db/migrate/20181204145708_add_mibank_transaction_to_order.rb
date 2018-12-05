class AddMibankTransactionToOrder < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :mibank_transaction, :integer
  end
end
