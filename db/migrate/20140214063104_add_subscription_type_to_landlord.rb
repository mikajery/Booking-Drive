class AddSubscriptionTypeToLandlord < ActiveRecord::Migration
  def change
    add_column :landlords, :subscription_type, :string
  end
end
