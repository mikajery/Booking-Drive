class AddPaypalTokenToPayment < ActiveRecord::Migration
  def change
    add_column :payments, :paypal_token, :string
  end
end
