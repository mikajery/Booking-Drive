# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :book do
    user_id "MyString"
    drive_id "MyString"
    start_date "2014-06-05"
    end_date "2014-06-05"
    status false
  end
end
