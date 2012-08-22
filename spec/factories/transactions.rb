# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :transaction do
    total_price 1.5
    notes "MyText"
    paid false
    type 1
    after(:build) do |transaction|
      transaction.therapist = FactoryGirl.build :therapist
      transaction.customer = FactoryGirl.build :clientnonmember
    end
  end
end
