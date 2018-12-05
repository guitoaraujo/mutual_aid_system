class ChangeMibankTransactionToStringInOrders < ActiveRecord::Migration[5.1]
  def change
    change_column :orders, :mibank_transaction, :string
  end
end
