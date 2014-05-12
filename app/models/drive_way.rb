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
  has_many :drive_way_prices
  has_many :drive_way_availabilities
  accepts_nested_attributes_for :drive_way_prices
  accepts_nested_attributes_for :drive_way_availabilities

  def drive_way_prices_builds
    return drive_way_prices if drive_way_prices.present?
    drive_way_prices.build
  end
  def drive_way_availabilities_builds
    return drive_way_availabilities if drive_way_availabilities.present?
    drive_way_availabilities.build
  end
end
