# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :users_drive_way, :class => 'Users::DriveWay' do
    price 1.5
    name "MyString"
    description "MyString"
  end
end
