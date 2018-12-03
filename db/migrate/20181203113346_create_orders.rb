class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.integer :order_type
      t.decimal :value
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
