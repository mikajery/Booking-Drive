class AddSubscriptionIdToSubscriptionPayment < ActiveRecord::Migration
  def change
    add_column :subscription_payments, :subscription_id, :integer
  end
end
