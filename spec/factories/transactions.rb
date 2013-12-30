# == Schema Information
#
# Table name: transactions
#
#  id               :integer          not null, primary key
#  customer_id      :integer
#  total_price      :float            default(0.0)
#  therapist_id     :integer
#  notes            :text
#  paid             :boolean          default(FALSE)
#  transaction_type :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  transac_date     :date
#

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
      transaction.services << FactoryGirl.build(:service)
    end
  end
end
