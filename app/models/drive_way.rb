# == Schema Information
#
# Table name: drive_ways
#
#  id          :integer          not null, primary key
#  price       :float
#  description :string(255)
#  name        :string(255)
#  picture     :string(255)
#  drive_id    :integer
#  created_at  :datetime
#  updated_at  :datetime
#

class DriveWay < ActiveRecord::Base
  belongs_to :drive
  mount_uploader :picture, PictureUploader
end
