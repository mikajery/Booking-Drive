# == Schema Information
#
# Table name: drives
#
#  id               :integer          not null, primary key
#  property_type    :string(255)
#  name_of_building :string(255)
#  description      :string(255)
#  address          :string(255)
#  city             :string(255)
#  state            :string(255)
#  country          :string(255)
#  zip_code         :string(255)
#  phone            :string(255)
#  notes            :text
#  latitude         :float
#  longitude        :float
#  landlord_id      :integer
#  created_at       :datetime
#  updated_at       :datetime
#

class Drive < ActiveRecord::Base
  belongs_to :landlord
  belongs_to :tenant
  geocoded_by :address
  after_validation :geocode, :if => :address_changed?
  has_many :drive_ways
  accepts_nested_attributes_for :drive_ways

  def drive_ways_builds
    return drive_ways if drive_ways.present?
    drive_ways.build
  end
end
