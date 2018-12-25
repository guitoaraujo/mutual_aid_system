class CreateCicles < ActiveRecord::Migration[5.1]
  def change
    create_table :cicles do |t|
      t.references :order, foreign_key: true
      t.integer :phase, default: 1
      t.integer :status
      t.datetime :complete_date

      t.timestamps
    end
  end
end
