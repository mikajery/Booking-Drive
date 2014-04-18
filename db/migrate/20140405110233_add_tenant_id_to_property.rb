class AddTenantIdToProperty < ActiveRecord::Migration
  def change
    add_column :properties, :tenant_id, :string
  end
end
