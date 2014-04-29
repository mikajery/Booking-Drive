class CreateDriveWays < ActiveRecord::Migration
  def change
    create_table :drive_ways do |t|
      t.float       :price, precision: 2
      t.string       :description
      t.string       :name
      t.timestamps
    end
  end
end