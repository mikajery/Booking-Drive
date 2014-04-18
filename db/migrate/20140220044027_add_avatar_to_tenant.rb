class AddAvatarToTenant < ActiveRecord::Migration
  def change
    add_column :tenants, :avatar, :string
  end
end
