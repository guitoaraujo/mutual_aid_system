class CreateCicles < ActiveRecord::Migration[5.1]
  def change
    create_table :cicles do |t|
      t.references :user, foreign_key: true
      t.string :phase
      t.string :status

      t.timestamps
    end
  end
end
