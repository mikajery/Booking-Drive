class CreateTenants < ActiveRecord::Migration
  def change
    create_table :tenants do |t|
      t.string :first_name
      t.string :middle_name
      t.string :last_name
      t.string :sex
      t.date :dob
      t.string :primary_email
      t.string :secondary_email
      t.string :primary_phone
      t.string :secondary_phone
      t.text :notes
      t.references :user, index: true

      t.timestamps
    end
  end
end
