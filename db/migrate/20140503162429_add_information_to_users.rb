class AddInformationToUsers < ActiveRecord::Migration
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :phone, :string
    add_column :users, :city, :string
    add_column :users, :state, :string
    add_column :users, :country, :string
    add_column :users, :address1, :string
    add_column :users, :address2, :string
    add_column :users, :birthday, :date
    add_column :users, :gender, :string
    add_column :users, :zipcode, :string
    add_column :users, :picture, :string
  end
end
