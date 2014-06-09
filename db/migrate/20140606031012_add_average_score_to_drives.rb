class AddAverageScoreToDrives < ActiveRecord::Migration
  def change
  	 add_column :drives, :average_score, :float
  end
end
