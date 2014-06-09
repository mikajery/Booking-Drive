# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :drive_feedback do
    drive_id "MyString"
    user_id "MyString"
    score 1.5
    feed_msg "MyText"
  end
end
