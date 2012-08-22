# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :reservation do
    number_people 1
    datetime "2012-08-22 16:48:06"
    name "MyString"
  end
end
