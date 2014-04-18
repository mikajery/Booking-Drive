class CreateConnections < ActiveRecord::Migration
  def change
    create_table :connections do |t|
      t.boolean :approved
      t.references :landlord, index: true
      t.references :tenant, index: true

      t.timestamps
    end
  end
end
