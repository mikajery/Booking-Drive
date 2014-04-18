class AddRoomNoToContracts < ActiveRecord::Migration
  def change
    add_column :contracts, :room_no, :string
  end
end
