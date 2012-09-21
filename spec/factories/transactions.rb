# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :transaction do
    total_price 1.5
    notes "MyText"
    paid false
    transaction_type 1
    transac_date Date.current
    after(:create) do |transaction|
      transaction.therapist = FactoryGirl.create(:therapist, :user_t2).account
      transaction.customer = FactoryGirl.create(:clientnonmember, :user_cnm2).account
      transaction.services << FactoryGirl.create(:service, :s3)
    end
    after(:build) do |transaction|
      transaction.therapist = FactoryGirl.build(:therapist).account
      transaction.customer = FactoryGirl.build(:clientnonmember).account
      transaction.services << FactoryGirl.build(:service)
    end
  end
end
