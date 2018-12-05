class CreateWithdraws < ActiveRecord::Migration[5.1]
  def change
    create_table :withdraws do |t|
      t.references :user, foreign_key: true
      t.decimal :value
      t.datetime :expires_in

      t.timestamps
    end
  end
end
