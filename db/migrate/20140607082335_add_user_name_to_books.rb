class AddUserNameToBooks < ActiveRecord::Migration
  def change
    add_column :books, :username, :string
  end
end
