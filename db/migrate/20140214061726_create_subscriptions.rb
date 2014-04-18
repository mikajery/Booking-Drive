class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.string :subscription_type
      t.date :date_from
      t.date :date_to
      t.references :landlord, index: true

      t.timestamps
    end
  end
end
