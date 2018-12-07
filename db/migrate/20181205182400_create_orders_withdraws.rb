class CreateOrdersWithdraws < ActiveRecord::Migration[5.1]
  def change
    create_table :orders_withdraws do |t|
      t.references :order, foreign_key: true
      t.references :withdraw, foreign_key: true

      t.timestamps
    end
  end
end
