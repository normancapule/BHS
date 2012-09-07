# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :service do
    name "Service For All"
    service_type_id 1
    member_price_morn 1.0
    member_price_eve 1.1
    regular_price 2.0
  end
end
