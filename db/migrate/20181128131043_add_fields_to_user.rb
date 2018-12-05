class AddFieldsToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :name, :string
    add_column :users, :phone, :string
    add_column :users, :cpf, :string
    add_column :users, :country, :string
    add_column :users, :zipcode, :string
    add_column :users, :mibank, :string
    add_column :users, :admin, :boolean, default: false
    add_column :users, :status, :integer, default: 0
  end
end
