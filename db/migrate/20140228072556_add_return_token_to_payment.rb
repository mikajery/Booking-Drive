class AddReturnTokenToPayment < ActiveRecord::Migration
  def change
    add_column :payments, :return_token, :string
  end
end
