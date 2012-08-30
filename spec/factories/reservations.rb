# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :reservation do
    number_people 1
    datetime DateTime.current
    name "MyString"
  end
end
