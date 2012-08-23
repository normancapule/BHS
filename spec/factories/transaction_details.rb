# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :transaction_detail do
    transaction_id 1
    service_id 1
    price_type 1
  end
end
