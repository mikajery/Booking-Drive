class CreateLandlords < ActiveRecord::Migration
  def change
    create_table :landlords do |t|
      t.string :first_name
      t.string :middle_name
      t.string :last_name
      t.string :address_line_1
      t.string :address_line_2
      t.string :city_town
      t.string :province_state_county_region
      t.string :country
      t.string :primary_phone
      t.string :secondary_phone
      t.string :vat_number
      t.string :paypal_email_id
      t.string :bank_account_no
      t.string :bank_name
      t.string :bank_branch
      t.string :currency
      t.string :company_name
      t.text :company_description
      t.references :user, index: true

      t.timestamps
    end
  end
end
