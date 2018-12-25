class AddUserToCicle < ActiveRecord::Migration[5.1]
  def change
    add_reference :cicles, :user, foreign_key: true
  end
end
