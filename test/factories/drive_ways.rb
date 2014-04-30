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

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :drive_way do
  end
end
