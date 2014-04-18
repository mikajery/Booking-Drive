class AddEmailToConnections < ActiveRecord::Migration
  def change
    add_column :connections, :tenant_email, :string
  end
end
