class AddReturnTokenToSubscription < ActiveRecord::Migration
  def change
    add_column :subscriptions, :return_token, :string
  end
end
