# == Schema Information
#
# Table name: properties
#
#  id                           :integer          not null, primary key
#  property_type                :string(255)
#  number_of_rooms              :integer
#  name_of_building             :string(255)
#  address_line_1               :string(255)
#  string                       :string(255)
#  address_line_2               :string(255)
#  city_town                    :string(255)
#  province_state_county_region :string(255)
#  country                      :string(255)
#  post_code                    :string(255)
#  phone_number                 :string(255)
#  approx_rental                :decimal(, )
#  notes                        :text
#  landlord_id                  :integer
#  created_at                   :datetime
#  updated_at                   :datetime
#  tenant_id                    :string(255)
#

class Property < ActiveRecord::Base
  belongs_to :landlord
  belongs_to :tenant
end
