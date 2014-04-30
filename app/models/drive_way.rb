# == Schema Information
#
# Table name: drive_ways
#
#  id          :integer          not null, primary key
#  price       :float
#  description :string(255)
#  name        :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

class DriveWay < ActiveRecord::Base
  # belongs_to :drives
end
