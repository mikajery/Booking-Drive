class AddAvatarToLandlord < ActiveRecord::Migration
  def change
    add_column :landlords, :avatar, :string
  end
end
