# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :drive_way_availability do
    from "2014-05-12"
    to "2014-05-12"
    inclusion 1
  end
end
