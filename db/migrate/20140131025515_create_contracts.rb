class CreateContracts < ActiveRecord::Migration
  def change
    create_table :contracts do |t|
      t.date :start_date
      t.date :end_date
      t.references :tenant, index: true
      t.references :landlord, index: true
      t.references :property, index: true
      t.decimal :rental_amount
      t.integer :pay_date

      t.timestamps
    end
  end
end
