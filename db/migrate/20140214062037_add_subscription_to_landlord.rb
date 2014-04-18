class AddSubscriptionToLandlord < ActiveRecord::Migration
  def change
    add_reference :landlords, :subscription, index: true
  end
end
