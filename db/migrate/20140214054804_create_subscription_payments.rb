class CreateSubscriptionPayments < ActiveRecord::Migration
  def change
    create_table :subscription_payments do |t|
      t.string :subscription_type
      t.decimal :amount
      t.date :date_from
      t.decimal :date_to
      t.string :payment_for
      t.date :payment_date

      t.timestamps
    end
  end
end
