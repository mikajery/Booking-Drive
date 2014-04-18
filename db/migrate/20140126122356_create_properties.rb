class CreateProperties < ActiveRecord::Migration
  def change
    create_table :properties do |t|
      t.string :property_type
      t.integer :number_of_rooms
      t.string :name_of_building
      t.string :address_line_1
      t.string :string
      t.string :address_line_2
      t.string :city_town
      t.string :province_state_county_region
      t.string :country
      t.string :post_code
      t.string :phone_number
      t.decimal :approx_rental
      t.text :notes
      t.references :landlord, index: true

      t.timestamps
    end
  end
end
