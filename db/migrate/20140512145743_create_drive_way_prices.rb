class CreateDriveWayPrices < ActiveRecord::Migration
  def change
    create_table :drive_way_prices do |t|
      t.integer    :days
      t.decimal    :price
      t.references :drive_way

      t.timestamps
    end
  end
end
