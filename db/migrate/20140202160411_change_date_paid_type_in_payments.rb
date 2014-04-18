class ChangeDatePaidTypeInPayments < ActiveRecord::Migration
  def change
  	    change_column :payments, :date_paid, :date

  end
end
