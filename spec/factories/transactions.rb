# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :transaction do
    total_price 1.5
    notes "MyText"
    paid false
    transaction_type 1
    transac_date Date.current
    after(:build) do |transaction|
      transaction.therapist = FactoryGirl.build(:therapist).account
      transaction.customer = FactoryGirl.build(:clientnonmember).account
    end
  end
end
