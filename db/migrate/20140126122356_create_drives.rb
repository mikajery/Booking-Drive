class CreateDrives < ActiveRecord::Migration
  def change
    create_table :drives do |t|
      t.string      :property_type
      t.string      :name_of_building
      t.string      :building_number
      t.string      :description
      t.string      :address
      t.string      :city
      t.string      :state
      t.string      :country
      t.string      :zip_code
      t.string      :phone
      t.text        :notes
      t.float       :latitude
      t.float       :longitude
      t.references  :user, index: true
      t.timestamps
    end
  end
end
