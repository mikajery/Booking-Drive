class CreateDriveFeedbacks < ActiveRecord::Migration
  def change
    create_table :drive_feedbacks do |t|
      t.string :drive_id
      t.string :user_id
      t.float :score
      t.text :feed_msg

      t.timestamps
    end
  end
end
