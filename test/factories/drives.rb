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
