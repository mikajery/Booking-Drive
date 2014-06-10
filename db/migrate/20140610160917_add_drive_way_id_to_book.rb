class AddDriveWayIdToBook < ActiveRecord::Migration
  def change
    add_column :books, :drive_way_id, :string
  end
end
