class RemoveUsertypeFromUser < ActiveRecord::Migration
  def change
    remove_reference :users, :user_type, index: true
  end
end
