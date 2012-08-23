# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :service do
    name "MyString"
    service_type 1
    member_price_morn 0.0
    member_price_eve 0.0
    regular_price 0.0
  end
end
