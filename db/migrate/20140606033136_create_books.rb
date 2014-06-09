class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :user_id
      t.string :drive_id
      t.date :start_date
      t.date :end_date
      t.boolean :status

      t.timestamps
    end
  end
end
