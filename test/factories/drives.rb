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

# Read about factories at https://github.com/thoughtbot/factory_girl
require 'faker'
FactoryGirl.define do
  factory :drive do
    address  { Faker::Address.street_address }
    city     { Faker::Address.city }
    state    { Faker::Address.state }
    country  { Faker::Address.country }
    zip_code { Faker::Address.zip_code }
  end
end
