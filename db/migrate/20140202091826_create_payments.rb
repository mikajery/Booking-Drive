class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.references :tenant, index: true
      t.references :landlord, index: true
      t.references :contract, index: true
      t.references :property, index: true
      t.string :status
      t.date :due_date
      t.boolean :late_payment
      t.date :date_paid
      t.string :reference_no
      t.string :payment_method
      t.text :notes

      t.timestamps
    end
  end
end
