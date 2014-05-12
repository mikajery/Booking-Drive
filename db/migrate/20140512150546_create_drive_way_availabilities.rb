class CreateDriveWayAvailabilities < ActiveRecord::Migration
  def change
    create_table :drive_way_availabilities do |t|
      t.date :from
      t.date :to
      t.references :drive_way
      t.boolean :inclusion

      t.timestamps
    end
  end
end
